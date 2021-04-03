library ieee;
use ieee.std_logic_1164.all;
entity chu_lfsr is
    generic (W : integer := 8); -- width of output port
    port (
        clk : in std_logic;
        reset : in std_logic;
        -- slot interface 
        cs : in std_logic;
        write : in std_logic;
        read : in std_logic;
        addr : in std_logic_vector(4 downto 0);
        rd_data : out std_logic_vector(31 downto 0);
        wr_data : in std_logic_vector(31 downto 0)
    );
end chu_lfsr;

architecture arch of chu_lfsr is
signal lfsr_out : std_logic_vector(8 downto 0);
begin
    lfsr_unit : entity work.lfsr
        port map(
            clk => clk,
            reset => reset,
            lfsr_out => lfsr_out
        );
    -- slot read interface
    rd_data(8 downto 0) <= lfsr_out;
    rd_data(31 downto 9) <= (others => '0');
end arch;