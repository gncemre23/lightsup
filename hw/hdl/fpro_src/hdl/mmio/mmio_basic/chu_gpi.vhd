library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity chu_gpi is
   generic(W : integer := 8);  -- width of input port
   port(
      clk     : in  std_logic;
      reset   : in  std_logic;
      -- slot interface 
      cs      : in  std_logic;
      write   : in  std_logic;
      read    : in  std_logic;
      addr    : in  std_logic_vector(4 downto 0);
      rd_data : out std_logic_vector(31 downto 0);
      wr_data : in  std_logic_vector(31 downto 0);
      -- external signal
      din     : in  std_logic_vector(W-1 downto 0)
   );
end chu_gpi;

architecture arch of chu_gpi is
   signal rd_data_reg : std_logic_vector(W-1 downto 0);
begin
   -- input register
   process(clk, reset)
   begin
      if reset = '1' then
         rd_data_reg <= (others => '0');
      elsif (clk'event and clk = '1') then
         rd_data_reg <= din;
      end if;
   end process;
   -- slot read interface
   rd_data(W-1 downto 0) <= rd_data_reg;
   rd_data(31 downto W)  <= (others => '0');
end arch;
