library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity chu_ddfs_core is
   generic(PW : integer := 30);   -- width of phase accumulator
   port(
      clk         : in  std_logic;
      reset       : in  std_logic;
      -- slot interface
      cs          : in  std_logic;
      write       : in  std_logic;
      read        : in  std_logic;
      addr        : in  std_logic_vector(4 downto 0);
      rd_data     : out std_logic_vector(31 downto 0);
      wr_data     : in  std_logic_vector(31 downto 0);
      -- external modulation input 
      focw_ext    : in  std_logic_vector(PW-1 downto 0);
      pha_ext     : in  std_logic_vector(PW-1 downto 0);
      env_ext     : in  std_logic_vector(15 downto 0);
      -- external output
      digital_out : out std_logic;
      pcm_out     : out std_logic_vector(15 downto 0);
      pdm_out     : out std_logic
   );
end chu_ddfs_core;

architecture arch of chu_ddfs_core is
   signal fccw_reg         : std_logic_vector(PW-1 downto 0);
   signal focw_reg, focw   : std_logic_vector(PW-1 downto 0);
   signal pha_reg, pha     : std_logic_vector(PW-1 downto 0);
   signal env_reg, env     : std_logic_vector(15 downto 0);
   signal ctrl_reg         : std_logic_vector(2 downto 0);
   signal wr_en            : std_logic;
   signal wr_fccw, wr_focw : std_logic;
   signal wr_pha, wr_env   : std_logic;
   signal wr_ctrl          : std_logic;
   signal pcm              : std_logic_vector(15 downto 0);
begin
   -- instantiate ddfs
   ddfs_unit : entity work.ddfs
      generic map(PW => PW)
      port map(
         clk       => clk,
         reset     => reset,
         fccw      => fccw_reg,
         focw      => focw,
         pha       => pha,
         env       => env,
         pcm_out   => pcm,
         pulse_out => digital_out
      );
   dac_unit : entity work.ds_1bit_dac
      generic map(W => 16)
      port map(clk     => clk,
               reset   => reset,
               pcm_in  => pcm,
               pdm_out => pdm_out
      );
   pcm_out <= pcm;
   -- registers
   process(clk, reset)
   begin
      if reset = '1' then
         fccw_reg <= (others => '0');
         focw_reg <= (others => '0');
         pha_reg  <= (others => '0');
         env_reg  <= x"4000";   -- 1.00
         ctrl_reg <= (others => '0');
      elsif (clk'event and clk = '1') then
         if wr_fccw = '1' then
            fccw_reg <= wr_data(PW-1 downto 0);
         end if;
         if wr_focw = '1' then
            focw_reg <= wr_data(PW-1 downto 0);
         end if;
         if wr_pha = '1' then
            pha_reg <= wr_data(PW-1 downto 0);
         end if;
         if wr_env = '1' then
            env_reg <= wr_data(15 downto 0);
         end if;
         if wr_ctrl = '1' then
            ctrl_reg <= wr_data(2 downto 0);
         end if;
      end if;
   end process;
   --decoding logic
   wr_en   <= '1' when write='1' and cs='1' else '0';
   wr_fccw <= '1' when addr(2 downto 0)="000" and wr_en='1' else '0';
   wr_focw <= '1' when addr(2 downto 0)="001" and wr_en='1' else '0';
   wr_pha  <= '1' when addr(2 downto 0)="010" and wr_en='1' else '0';
   wr_env  <= '1' when addr(2 downto 0)="011" and wr_en='1' else '0';
   wr_ctrl <= '1' when addr(2 downto 0)="100" and wr_en='1' else '0';
   -- input signal routing 
   env  <= env_reg when  ctrl_reg(0) = '0' else env_ext;
   focw <= focw_reg when ctrl_reg(1) = '0' else focw_ext;
   pha  <= pha_reg when  ctrl_reg(2) = '0' else pha_ext;
   -- read data 
   rd_data <= X"0000" & pcm;
end arch;
