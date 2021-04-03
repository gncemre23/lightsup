-- lfsr implementation
-- FF0 -> FF1 -> FF2 ->FF3 -> FF4 ... -> FF8

-- FF3 xor FF8 -> FF0

-- lfsr_out = (FF0 | FF1 | FF2 | ...| FF8)
-- initial value with the reset input is
-- "010101010"

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity lfsr_test is
end lfsr_test;

architecture arch of lfsr_test is
    signal lfsr_out : std_logic_vector(8 downto 0);
    signal clk : std_logic;
    signal reset : std_logic;
    signal init : std_logic;
begin

    V0 : entity work.lfsr
    port map(
        clk => clk,
        reset => reset,
        lfsr_out => lfsr_out,
        init => init
    );

    clk_process : process
    begin
        clk <= '1';
        wait for 1000 ms;
        clk <= '0';
        wait for 1000 ms;
    end process;

    print:process
    begin
        wait for 2000 ms;
        report "The value of 'lfsr_out' is " & to_bstring(lfsr_out);       
    end process;

    tb_process : process
    begin
        reset <= '1';
        wait for 2000 ms;
        reset <= '0';
        wait for 10000 ms;
        init <= '1';
        wait for 2000 ms;
        init <= '0';
        wait for 10000 ms;
        wait;
    end process;

end arch;
