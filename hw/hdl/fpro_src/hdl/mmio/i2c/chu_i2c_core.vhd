library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity chu_i2c_core is
   port(
      clk     : in std_logic;
      reset   : in std_logic;
      -- slot interface
      cs      : in std_logic;
      write   : in std_logic;
      read    : in std_logic;       
      addr    : in std_logic_vector(4 downto 0);  
      rd_data : out std_logic_vector(31 downto 0);
      wr_data : in std_logic_vector(31 downto 0);
      -- external signals 
      scl     : out std_logic;
      sda     : inout std_logic
   );
end chu_i2c_core;

architecture arch of chu_i2c_core is
   signal ready, ack : std_logic;
   signal dout       : std_logic_vector(7 downto 0);
   signal dvsr_reg   : std_logic_vector(15 downto 0);
   signal wr_en      : std_logic;
   signal wr_i2c     : std_logic;
   signal wr_dvsr    : std_logic;
begin
   -- instantiate codec controller   
   i2c_unit : entity work.i2c_master(arch)
      port map(
         clk       => clk,
         reset     => reset,
         din       => wr_data(7 downto 0),
         cmd       => wr_data(10 downto 8),
         dvsr      => dvsr_reg,
         wr_i2c    => wr_i2c,
         scl       => scl,
         sda       => sda,
         ready     => ready,
         done_tick => open,
         ack       => ack,
         dout      => dout);
   -- registers
   process(clk, reset)
   begin
      if reset = '1' then
         dvsr_reg <= (others => '0');
      elsif (clk'event and clk = '1') then
         if wr_dvsr = '1' then
            dvsr_reg <= wr_data(15 downto 0);
         end if;
      end if;
   end process;
   --decoding logic
   wr_en   <= '1' when write='1' and cs='1' else '0';
   wr_dvsr <= '1' when addr(0 downto 0)="0" and wr_en='1' else '0';
   wr_i2c  <= '1' when addr(0 downto 0)="1" and wr_en='1' else '0';
   -- read data  
   rd_data <= x"00000" & "00" & ack & ready & dout;
end arch;
