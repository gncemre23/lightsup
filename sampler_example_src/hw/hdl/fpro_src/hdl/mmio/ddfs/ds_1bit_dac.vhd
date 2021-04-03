library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity ds_1bit_dac is
   generic(W : integer := 16);   -- width of input
   port(
      clk     : in std_logic;
      reset   : in std_logic;
      pcm_in  : in std_logic_vector(W - 1 downto 0);
      pdm_out : out std_logic
   );
end ds_1bit_dac;

architecture arch of ds_1bit_dac is
   constant BIAS  : unsigned(W downto 0) := ((W-1)=>'1', others=>'0');
   signal pcm_biased : unsigned(W downto 0);
   signal acc_reg    : unsigned(W downto 0);
   signal acc_next   : unsigned(W downto 0);
begin
   -- shift range from [-(2^(W-1)), 2^(W-1)-1] to [0, 2^W-1)] 
   pcm_biased <= unsigned(pcm_in(W - 1) & pcm_in) + BIAS;
   -- signal treated as unsigned number in delta-sigma modulation
   acc_next   <= ('0' & acc_reg(W - 1 downto 0)) + pcm_biased;
   process(clk, reset)
   begin
      if reset = '1' then
         acc_reg <= (others => '0');
      elsif (clk'event and clk = '1') then
         acc_reg <= acc_next;
      end if;
   end process;
   pdm_out <= acc_reg(W);
end arch;
