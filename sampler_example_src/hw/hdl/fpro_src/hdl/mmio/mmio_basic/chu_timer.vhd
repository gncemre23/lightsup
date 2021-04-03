--  Reg map;
--    * 00: read (32 LSB of counter)
--    * 01: read (16 MSB of counter)
--    * 10: control register: 
--        bit 0: go/pause
--        bit 1: clear (no memory, just used to generate a 1-clock pulse)
--
--  * 48-bit counter (up to 32 days)

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity chu_timer is
   port(
      clk     : in  std_logic;
      reset   : in  std_logic;
      -- slot interface 
      cs      : in  std_logic;
      write   : in  std_logic;
      read    : in  std_logic;
      addr    : in  std_logic_vector(4 downto 0);
      rd_data : out std_logic_vector(31 downto 0);
      wr_data : in  std_logic_vector(31 downto 0)
   );
end chu_timer;

architecture arch of chu_timer is
   signal count_reg  : unsigned(47 downto 0);
   signal count_next : unsigned(47 downto 0);
   signal ctrl_reg   : std_logic;
   signal wr_en      : std_logic;
   signal clear, go  : std_logic;
begin
   --******************************************************************
   -- counter
   --******************************************************************
   -- register
   process(clk, reset)
   begin
      if reset = '1' then
         count_reg <= (others => '0');
      elsif (clk'event and clk = '1') then
         count_reg <= count_next;
      end if;
   end process;
   -- next-state logic 
   count_next <= (others => '0') when clear = '1' else
                 count_reg + 1   when go = '1' else
                 count_reg;

   --******************************************************************
   -- wrapping circuit
   --******************************************************************
  -- ctrl register
   process(clk, reset)
   begin
      if reset = '1' then
         ctrl_reg <= '0';
      elsif (clk'event and clk = '1') then
         if wr_en = '1' then
            ctrl_reg <= wr_data(0);
         end if;
      end if;
   end process;
   -- decoding logic
   wr_en <= 
      '1' when write='1' and cs='1' and addr(1 downto 0)="10" else '0';
   clear <= '1' when wr_en='1' and wr_data(1)='1' else '0';
   go    <= ctrl_reg;
   -- slot read multiplexing
   rd_data <= 
      std_logic_vector(count_reg(31 downto 0)) when addr(0)='0' else 
      x"0000" & std_logic_vector(count_reg(47 downto 32));
end arch;
