-- ADSR output 31-bit envelop 
--   16 bits: max 6 ms attack time; 31 bits: 200 sec attack time
--   use 31 bits to avoid overflow problem in C
-- AW:use 31 bits 
--    * simplify C code (no need to use unsigned int)
--    * simplify VHDL simulation (Xilinx ISIM use 32-bit integer)
--    * can accomodate 20 sec for 100 MHz clock 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity chu_adsr_core is
   port(
      clk      : in  std_logic;
      reset    : in  std_logic;
      -- slot interface
      cs       : in  std_logic;
      write    : in  std_logic;
      read     : in  std_logic;
      addr     : in  std_logic_vector(4 downto 0);
      rd_data  : out std_logic_vector(31 downto 0);
      wr_data  : in  std_logic_vector(31 downto 0);
      -- external signal
      adsr_env : out std_logic_vector(15 downto 0)
   );
end chu_adsr_core;

architecture arch of chu_adsr_core is
   signal atk_step_reg   : std_logic_vector(31 downto 0);
   signal dcy_step_reg   : std_logic_vector(31 downto 0);
   signal sus_level_reg  : std_logic_vector(31 downto 0);
   signal rel_step_reg   : std_logic_vector(31 downto 0);
   signal sus_time_reg   : std_logic_vector(31 downto 0);
   signal idle           : std_logic;
   signal wr_en          : std_logic;
   signal wr_atk, wr_dcy : std_logic;
   signal wr_sus_lvl     : std_logic;
   signal wr_rel         : std_logic;
   signal wr_start       : std_logic;
   signal wr_sus_time    : std_logic;

begin
   -- instantiate adsr generator
   adsr_unit : entity work.adsr
      port map(
         clk       => clk,
         reset     => reset,
         start     => wr_start,
         atk_step  => atk_step_reg,
         dcy_step  => dcy_step_reg,
         sus_level => sus_level_reg,
         sus_time  => sus_time_reg,
         rel_step  => rel_step_reg,
         env       => adsr_env,
         adsr_idle => idle
      );
   -- registers
   process(clk, reset)
   begin
      if reset = '1' then
         atk_step_reg  <= (others => '0');
         dcy_step_reg  <= (others => '0');
         sus_level_reg <= (others => '0');
         rel_step_reg  <= (others => '0');
         sus_time_reg  <= (others => '0');
      elsif (clk'event and clk = '1') then
         if wr_atk = '1' then
            atk_step_reg <= wr_data;
         end if;
         if wr_dcy = '1' then
            dcy_step_reg <= wr_data;
         end if;
         if wr_sus_lvl = '1' then
            sus_level_reg <= wr_data;
         end if;
         if wr_rel = '1' then
            rel_step_reg <= wr_data;
         end if;
         if wr_sus_time = '1' then
            sus_time_reg <= wr_data;
         end if;
      end if;
   end process;
   -- decoding logic
   wr_en       <= '1' when write = '1' and cs = '1' else '0';
   wr_start    <= '1' when addr(2 downto 0)="000" and wr_en='1' else '0';
   wr_atk      <= '1' when addr(2 downto 0)="001" and wr_en='1' else '0';
   wr_dcy      <= '1' when addr(2 downto 0)="010" and wr_en='1' else '0';
   wr_sus_time <= '1' when addr(2 downto 0)="011" and wr_en='1' else '0';
   wr_rel      <= '1' when addr(2 downto 0)="100" and wr_en='1' else '0';
   wr_sus_lvl  <= '1' when addr(2 downto 0)="101" and wr_en='1' else '0';
   -- read data
   rd_data     <= x"0000000" & "000" & idle;
end arch;
