library ieee;
use ieee.std_logic_1164.all;

entity chu_led_mux_core is
   port(
      clk     : in  std_logic;
      reset   : in  std_logic;
      -- io bridge interface
      cs      : in  std_logic;
      write   : in  std_logic;
      read    : in  std_logic;  -- not used 
      addr    : in  std_logic_vector(4 downto 0);
      rd_data : out std_logic_vector(31 downto 0);
      wr_data : in  std_logic_vector(31 downto 0);
      -- external interface
      an      : out std_logic_vector(7 downto 0);
      sseg    : out std_logic_vector(7 downto 0)
   );
end chu_led_mux_core;

architecture arch of chu_led_mux_core is
   signal d0_reg, d1_reg : std_logic_vector(31 downto 0);
   signal wr_en          : std_logic;
   signal wr_d0          : std_logic;
   signal wr_d1          : std_logic;
begin
   -- instantiate LED multiplexing circuit
   led_mux_unit : entity work.led_mux8
      port map(
         clk   => clk,
         reset => reset,
         in7   => d1_reg(31 downto 24),
         in6   => d1_reg(23 downto 16),
         in5   => d1_reg(15 downto 8),
         in4   => d1_reg(7 downto 0),
         in3   => d0_reg(31 downto 24),
         in2   => d0_reg(23 downto 16),
         in1   => d0_reg(15 downto 8),
         in0   => d0_reg(7 downto 0),
         an    => an,
         sseg  => sseg
      );

   -- 2 write registers
   process(clk, reset)
   begin
      if reset = '1' then
         d0_reg <= (others => '0');
         d1_reg <= (others => '1');
      elsif (clk'event and clk = '1') then
         if wr_d0 = '1' then
            d0_reg <= wr_data(31 downto 0);
         end if;
         if wr_d1 = '1' then
            d1_reg <= wr_data(31 downto 0);
         end if;
      end if;
   end process;
   -- decoding circuit
   wr_en <= '1' when write = '1' and cs = '1' else '0';
   wr_d0 <= '1' when addr(0) = '0' and wr_en = '1' else '0';
   wr_d1 <= '1' when addr(0) = '1' and wr_en = '1' else '0';
   -- unused 
   rd_data <= (others => '0');
end arch;
