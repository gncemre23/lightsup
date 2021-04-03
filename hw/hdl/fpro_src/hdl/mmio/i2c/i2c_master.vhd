-- i2c single-master 
-- * Limitation
--     * only function as I2C master
--     * no arbitration (i.e., no other master allowed)
--     * do not support salve "clock-stretching"
-- * Input
--     cmd (command):  000:start, 001:write, 010:read, 011:stop, 100:restart
--     din: write:8-bit data;  read:LSB is ack/nack bit used in read
-- * Output:
--     dout: received data
--     ack: received ack in write (should be 0)
-- * Basic design
--     * external system
--          * generate proper start-write/read-stop condition
--          * use LSB of din (ack/nack) to indicate last byte in read
--     * FSM 
--          * loop 9 times for read/write (8 bit data + ack)
--          * no distiction between read/write 
--            (data  shift-in/shift-out simultaneously)
--     * Output control circuit   
--          * data out of sdat: loops 0-7 of write and loop 8 of read (send ack/nack)
--          * data into sdat: loops 0-7 of read and loop 8 of write (receive ack)
--    * dvsr: divisor to obtain a quarter of i2c clock period
--         
-- during a read operation, the LSB of din is the NACK bit
-- i.e., indicate whether the current read is the last one in read cycle
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity i2c_master is
   port(
      clk, reset : in    std_logic;
      din        : in    std_logic_vector(7 downto 0);
      cmd        : in    std_logic_vector(2 downto 0);
      dvsr       : in    std_logic_vector(15 downto 0);
      wr_i2c     : in    std_logic;
      scl        : out   std_logic;
      sda        : inout std_logic;
      ready      : out   std_logic;
      done_tick  : out   std_logic;
      ack        : out   std_logic;
      dout       : out   std_logic_vector(7 downto 0)
   );
end i2c_master;

architecture arch of i2c_master is
   constant START_CMD   : std_logic_vector(2 downto 0) := "000";
   constant WR_CMD      : std_logic_vector(2 downto 0) := "001";
   constant RD_CMD      : std_logic_vector(2 downto 0) := "010";
   constant STOP_CMD    : std_logic_vector(2 downto 0) := "011";
   constant RESTART_CMD : std_logic_vector(2 downto 0) := "100";
   type statetype is (
      idle, hold, start1, start2, data1, data2, data3, data4, data_end,
      restart, stop1, stop2);
   signal state_reg         : statetype;
   signal state_next        : statetype;
   signal c_reg, c_next     : unsigned(15 downto 0);
   signal qutr, half        : unsigned(15 downto 0);
   signal tx_reg, tx_next   : std_logic_vector(8 downto 0);
   signal rx_reg, rx_next   : std_logic_vector(8 downto 0);
   signal cmd_reg, cmd_next : std_logic_vector(2 downto 0);
   signal bit_reg, bit_next : unsigned(3 downto 0);
   signal sda_out, scl_out  : std_logic;
   signal sda_reg, scl_reg  : std_logic;
   signal into              : std_logic;
   signal nack              : std_logic;
   signal data_phase        : std_logic;
begin
   --******************************************************************
   -- output control logic
   --******************************************************************
   -- buffer for sda and scl lines 
   process(clk, reset)
   begin
      if reset = '1' then
         sda_reg <= '1';
         scl_reg <= '1';
      elsif (clk'event and clk = '1') then
         sda_reg <= sda_out;
         scl_reg <= scl_out;
      end if;
   end process;
   -- only master drives scl line  
   scl  <= 'Z' when scl_reg = '1' else '0';
   -- sda are with pull-up resistors
   -- and becomes high when not driven
   into <= '1' when 
      (data_phase = '1' and cmd_reg = RD_CMD and bit_reg < 8) or 
      (data_phase = '1' and cmd_reg = WR_CMD and bit_reg = 8) else '0';
   sda  <= 'Z' when into = '1' or sda_reg = '1' else '0';
   -- output
   dout <= rx_reg(8 downto 1);
   ack  <= rx_reg(0);   -- obtained from slave in write operation 
   nack <= din(0);      -- used by master in read operation 
   --******************************************************************
   -- fsmd 
   --******************************************************************
   -- registers
   process(clk, reset)
   begin
      if reset = '1' then
         state_reg <= idle;
         c_reg     <= (others => '0');
         bit_reg   <= (others => '0');
         cmd_reg   <= (others => '0');
         tx_reg    <= (others => '0');
         rx_reg    <= (others => '0');
      elsif (clk'event and clk = '1') then
         state_reg <= state_next;
         c_reg     <= c_next;
         bit_reg   <= bit_next;
         cmd_reg   <= cmd_next;
         tx_reg    <= tx_next;
         rx_reg    <= rx_next;
      end if;
   end process;
   --  intervals
   qutr <= unsigned(dvsr);
   half <= qutr(14 downto 0) & '0';   -- half = 2*qutr
   -- next-state logic
   process(state_reg, bit_reg, tx_reg, c_reg, rx_reg, cmd_reg, 
           cmd, din, wr_i2c, sda, nack, qutr, half)
   begin
      state_next <= state_reg;
      c_next     <= c_reg + 1;   -- timer counts continuously 
      bit_next   <= bit_reg;
      tx_next    <= tx_reg;
      rx_next    <= rx_reg;
      cmd_next   <= cmd_reg;
      done_tick  <= '0';
      ready      <= '0';
      scl_out    <= '1';
      sda_out    <= '1';
      data_phase <= '0';
      case state_reg is
         when idle =>
            ready <= '1';
            if wr_i2c = '1' and cmd = START_CMD then -- start 
               state_next <= start1;
               c_next     <= (others => '0');
            end if;
         when start1 =>     -- start condition 
            sda_out <= '0';
            if c_reg = half then
               c_next     <= (others => '0');
               state_next <= start2;
            end if;
         when start2 =>
            sda_out <= '0';
            scl_out <= '0';
            if c_reg = qutr then
               c_next     <= (others => '0');
               state_next <= hold;
            end if;
         when hold =>    -- in progress; prepare for the next op
            ready   <= '1';
            sda_out <= '0';
            scl_out <= '0';
            if wr_i2c = '1' then
               cmd_next <= cmd;
               c_next   <= (others => '0');
               case cmd is
                  when RESTART_CMD | START_CMD => 
                     state_next <= restart;
                  when STOP_CMD =>      
                     state_next <= stop1;
                  when others =>    -- read/write a byte
                     bit_next   <= (others => '0');
                     state_next <= data1;
                     tx_next    <= din & nack; --nack used in read 
               end case;
            end if;
         when data1 =>
            sda_out    <= tx_reg(8);
            scl_out    <= '0';
            data_phase <= '1';
            if c_reg = qutr then
               c_next     <= (others => '0');
               state_next <= data2;
            end if;
         when data2 =>
            sda_out    <= tx_reg(8);
            data_phase <= '1';
            if c_reg = qutr then
               c_next     <= (others => '0');
               state_next <= data3;
               rx_next    <= rx_reg(7 downto 0) & sda; 
            end if;
         when data3 =>
            sda_out    <= tx_reg(8);
            data_phase <= '1';
            if c_reg = qutr then
               c_next     <= (others => '0');
               state_next <= data4;
            end if;
         when data4 =>
            sda_out    <= tx_reg(8);
            scl_out    <= '0';
            data_phase <= '1';
            if c_reg = qutr then
               c_next <= (others => '0');
               if bit_reg = 8 then    -- done with 8 data bits + 1 ack
                  state_next <= data_end;  
                  done_tick  <= '1';
               else
                  tx_next    <= tx_reg(7 downto 0) & '0';
                  bit_next   <= bit_reg + 1;
                  state_next <= data1;
               end if;
            end if;
         when data_end =>
            sda_out <= '0';
            scl_out <= '0';
            if c_reg = qutr then
               c_next     <= (others => '0');
               state_next <= hold;
            end if;
         when restart =>   -- generate idle condition 
            if c_reg = half then
               c_next     <= (others => '0');
               state_next <= start1;
            end if;
         when stop1 =>    -- stop condition
            sda_out <= '0';
            if c_reg = half then
               c_next     <= (others => '0');
               state_next <= stop2;
            end if;
         when stop2 =>    -- turnaround time 
            if c_reg = half then
               state_next <= idle;
            end if;
      end case;
   end process;
end arch;
