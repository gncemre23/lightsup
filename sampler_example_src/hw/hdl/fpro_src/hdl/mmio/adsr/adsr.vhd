-- fsm to generate ADSR envelop
-- start (trigger) signal:
--     - starts the "attack" when asserted
--     - restarts the epoch if aseerted before the current epoch ends 
-- amplitudes:
--     - 32-bit unsigned   
--     - use 32 bits to accommodate the needed resolution for "step"
--     - intepreted as Q1.31 format:
--     - rnage artificially limited between 0.0 and 1.0
--     - i.e., 0.0...0 to 1.0...0 (1.0)
--     - 1.1xx...x not allowed
-- output: Q2.14 for range (-1.0 to 1.0)
-- special atk_step values
--     - atk_step = 11..11: bypass adsr; i.e., envelop=1.0
--     - atk_step = 00..00: output 0; i.e., envelop = 0.0
-- Width selection: 
--   max attack time = 2^31 * clock period 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity adsr is
   port(
      clk       : in  std_logic;
      reset     : in  std_logic;
      start     : in  std_logic;
      atk_step  : in  std_logic_vector(31 downto 0); 
      dcy_step  : in  std_logic_vector(31 downto 0); 
      sus_level : in  std_logic_vector(31 downto 0); 
      sus_time  : in  std_logic_vector(31 downto 0); 
      rel_step  : in  std_logic_vector(31 downto 0); 
      env       : out std_logic_vector(15 downto 0);
      adsr_idle : out std_logic
   );
end adsr;

architecture arch of adsr is
   type state_type is (idle, launch, attack, decay, sustain, release);
   constant MAX    : unsigned(31 downto 0) := x"80000000";
   constant BYPASS : std_logic_vector(31 downto 0):=(others => '1');
   constant ZERO   : std_logic_vector(31 downto 0):=(others => '0');
   signal state_reg     : state_type;
   signal state_next    : state_type;
   signal a_reg, a_next : unsigned(31 downto 0);
   signal t_reg, t_next : unsigned(31 downto 0);
   signal env_i         : unsigned(31 downto 0);
   signal a_atk, a_dcy  : unsigned(31 downto 0);

begin
   -- fsmd state and data registers
   process(clk, reset)
   begin
      if reset = '1' then
         state_reg <= idle;
         a_reg     <= (others => '0');
         t_reg     <= (others => '0');
      elsif (clk'event and clk = '1') then
         state_reg <= state_next;
         a_reg     <= a_next;
         t_reg     <= t_next;
      end if;
   end process;
   -- atttack value calculation 
   a_atk <= a_reg + unsigned(atk_step);
   a_dcy <= a_reg - unsigned(dcy_step);
   -- next-state logic and data path logic
   process(state_reg, a_reg, start, sus_level, rel_step, 
           sus_time, t_reg, a_atk, a_dcy)
   begin
      state_next <= state_reg;
      a_next     <= a_reg;
      adsr_idle  <= '0';
      t_next     <= t_reg;
      case state_reg is
         when idle =>
            adsr_idle <= '1';
            if (start = '1') then
               state_next <= launch;
            end if;
         when launch =>
            state_next <= attack;
            a_next     <= (others => '0'); 
         when attack =>
            if (start = '1') then
               state_next <= launch;
            else
               if (a_atk < MAX) then
                  a_next <= a_atk;
               else
                  state_next <= decay;
               end if;
            end if;
         when decay =>
            if (start = '1') then
               state_next <= launch;
            else
               if (a_dcy > unsigned(sus_level)) then
                  a_next <= a_dcy;
               else
                  a_next     <= unsigned(sus_level);
                  state_next <= sustain;
                  t_next     <= (others => '0'); 
               end if;
            end if;
         when sustain =>
            if (start = '1') then
               state_next <= launch;
            else
               if (t_reg <= unsigned(sus_time)) then
                  t_next <= t_reg + 1;
               else
                  state_next <= release;
               end if;
            end if;

         when release =>
            if (start = '1') then
               state_next <= launch;
            else
               if (a_reg > unsigned(rel_step)) then
                  a_next <= a_reg - unsigned(rel_step);
               else
                  state_next <= idle;
               end if;
            end if;
      end case;
   end process;
   -- special cases
   env_i <= MAX when atk_step=BYPASS else 
            (others => '0') when atk_step = ZERO else 
            a_reg;
   env <= '0' & std_logic_vector(env_i(31 downto 17));
end arch;