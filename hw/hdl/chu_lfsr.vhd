--  Reg map;
--    * 00: read LFSR out
--    * 01: control register
--         wr_data(0) : init (load hardcoded initial value to the registers)                
                          
                          
library ieee;
use ieee.std_logic_1164.all;
entity chu_lfsr is
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
signal init : std_logic;
signal wr_en  : std_logic;
begin

    lfsr_unit : entity work.lfsr
        port map(
            clk => clk,
            reset => reset,
            lfsr_out => lfsr_out,
            init  => init
        );
    ---- decoding logic
    wr_en <= '1' when write='1' and cs='1' and addr(1 downto 0)="10" else '0';
    init <= '1' when wr_en='1' and wr_data(0)='1' else '0';
    -- slot read interface
    rd_data(8 downto 0) <= lfsr_out;
    rd_data(31 downto 9) <= (others => '0');
end arch;