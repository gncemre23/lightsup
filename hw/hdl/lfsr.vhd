-- lfsr implementation
-- FF0 -> FF1 -> FF2 ->FF3 -> FF4 ... -> FF8

-- FF3 xor FF8 -> FF0

-- lfsr_out = (FF0 | FF1 | FF2 | ...| FF8)
-- initial value with the reset input is
-- "010101010"

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity lfsr is
   port (
      clk : in std_logic;
      reset : in std_logic;
      init : in std_logic;
      lfsr_out : out std_logic_vector(8 downto 0)
   );
end lfsr;

architecture arch of lfsr is
   signal shift_reg : std_logic_vector(8 downto 0);
begin

   lfsr_out <= shift_reg;

   --shift register implementation
   process (clk, reset)
   begin
      if reset = '1' or init = '1' then
         shift_reg <= "010101010";
      elsif (clk'event and clk = '1') then
         shift_reg(7) <= shift_reg(8);
         shift_reg(6) <= shift_reg(7);
         shift_reg(5) <= shift_reg(6);
         shift_reg(4) <= shift_reg(5);
         shift_reg(3) <= shift_reg(4);
         shift_reg(2) <= shift_reg(3);
         shift_reg(1) <= shift_reg(2);
         shift_reg(0) <= shift_reg(1);
         shift_reg(8) <= shift_reg(0) xor shift_reg(5);
      end if;
   end process;

end arch;
