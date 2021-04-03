library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity led_mux8 is
   port(
      clk, reset         : in  std_logic;
      in3, in2, in1, in0 : in  std_logic_vector(7 downto 0);
      in7, in6, in5, in4 : in  std_logic_vector(7 downto 0);
      an                 : out std_logic_vector(7 downto 0);
      sseg               : out std_logic_vector(7 downto 0)
   );
end led_mux8;

architecture arch of led_mux8 is
   -- refreshing rate around 1600 Hz (100MHz/2^16)
   constant N           : integer := 18;
   signal q_reg, q_next : unsigned(N - 1 downto 0);
   signal sel           : std_logic_vector(2 downto 0);
begin
   -- register
   process(clk, reset)
   begin
      if reset = '1' then
         q_reg <= (others => '0');
      elsif (clk'event and clk = '1') then
         q_reg <= q_next;
      end if;
   end process;
   -- next-state logic for the counter
   q_next <= q_reg + 1;
   -- 3 MSBs of counter to control 8-to-1 multiplexing
   -- and to generate active-low enable signal
   sel <= std_logic_vector(q_reg(N - 1 downto N - 3));
   process(sel, in0, in1, in2, in3, in4, in5, in6, in7)
   begin
      case sel is
         when "000" =>
            an   <= "11111110";
            sseg <= in0;
         when "001" =>
            an   <= "11111101";
            sseg <= in1;
         when "010" =>
            an   <= "11111011";
            sseg <= in2;
         when "011" =>
            an   <= "11110111";
            sseg <= in3;
         when "100" =>
            an   <= "11101111";
            sseg <= in4;
         when "101" =>
            an   <= "11011111";
            sseg <= in5;
         when "110" =>
            an   <= "10111111";
            sseg <= in6;
         when others =>
            an   <= "01111111";
            sseg <= in7;
      end case;
   end process;
end arch;