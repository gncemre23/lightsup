----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/03/2021 09:34:00 PM
-- Design Name: 
-- Module Name: test_bench_for_complete_system - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_bench_for_complete_system is
end test_bench_for_complete_system;

architecture Behavioral of test_bench_for_complete_system is

signal clk : std_logic;
signal reset : std_logic;
signal sw : std_logic_vector(15 downto 0);
signal btn : std_logic_vector(4 downto 0);
signal sseg : std_logic_vector ( 7 downto 0);
signal an   : std_logic_vector(3 downto 0);
signal rx   : std_logic;
signal adc_p : std_logic_vector(3 downto 0);
signal adc_n : std_logic_vector(3 downto 0);

constant bridge_base : std_logic_vector := x"C0000000";
begin


instance0: entity work.mcs_top_sampler_basys3
  -- generic map (BRIDGE_BASE => bridge_base)
   port map(
      clk => clk,
      reset => reset,
      -- reset_n     : in    std_logic;
      -- switches and LEDs
      sw => sw,      --   : in    std_logic_vector(15 downto 0);
      led  => open, --       : out   std_logic_vector(15 downto 0);
      -- uart
      rx  => rx, --        : in    std_logic;
      tx  => open, --        : out   std_logic;
      -- xadc
      adc_p   => adc_p, --    : in    std_logic_vector(3 downto 0);
      adc_n   => adc_n, --    : in    std_logic_vector(3 downto 0);
      -- rgb leds
      -- rgb_led1    : out   std_logic_vector(2 downto 0);
      -- rgb_led2    : out   std_logic_vector(2 downto 0);
      -- buttons
      btn => btn, --        : in    std_logic_vector(4 downto 0);
      -- 4-digit 7-seg LEDs
      sseg => sseg, --       : out   std_logic_vector(7 downto 0);
      --an          : out   std_logic_vector(7 downto 0);
      an => an, --          : out   std_logic_vector(3 downto 0);
      -- spi accelerator
      -- acl_sclk    : out   std_logic;
      -- acl_mosi    : out   std_logic;
      -- acl_miso    : in    std_logic;
      -- acl_ss_n    : out   std_logic;
      -- i2c temperature sensor
      -- tmp_i2c_scl : out   std_logic;
      -- tmp_i2c_sda : inout std_logic;
      -- ps2
      ps2d  => open, --      : inout std_logic;
      ps2c  => open, --      : inout std_logic;
      -- nexsys 4 aduio
      -- audio_on    : out   std_logic;
      -- audio_pdm   : out   std_logic;
      -- PMOD JA (divided into top row and bottom row
      ja_top => open, --    : out   std_logic_vector(4 downto 1);
      ja_btm => open, --    : out   std_logic_vector(10 downto 7);
      -- PMOD JB (divided into top row and bottom row
      jb_top => open, --    : inout   std_logic_vector(4 downto 1);
      jb_btm => open, --    : inout   std_logic_vector(10 downto 7);
      -- PMOD JC (divided into top row and bottom row
      jc_top => open, --    : inout   std_logic_vector(4 downto 1);
      jc_btm => open --     : inout   std_logic_vector(10 downto 7)
   );
   
   
   clk_process: process
   begin
   clk <= '1';
   wait for 5 ns;
   clk <= '0';
   wait for 5 ns;  
   end process;
   
   
   stimuli_process: process
   begin
   reset <= '1';
   btn <= "00000";
   sw  <= x"0000";
   wait for 1000 ns;
   reset <= '0';
   wait for 1 ms;
   btn <= "10000"; -- btnc is pressed
   wait for 1 ms;
   btn <= "00000";
   wait for 10 ms;
   btn <= "00001"; -- btnu is pressed
   wait for 1 ms;
   btn <= "00000";
   
   wait for 10 ms;
   
   wait;
   
   end process;


end Behavioral;
