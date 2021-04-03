-- ********************************************************************
-- Revision with Basys3 board
-- ********************************************************************
--  * nexsys 4 ddr and basys3 use different adc chennels 
--  * basys3: 6=>adc(0), 7=>adc(2), 14=>adc(1), 15=>adc(3)
--  * need to re-conifgure/re-generate a new XADC instance
-- ********************************************************************
library ieee;
use ieee.std_logic_1164.all;
entity chu_xadc_basys3_core is
   port(
      clk     : in  std_logic;
      reset   : in  std_logic;
      -- slot interface
      cs      : in  std_logic;
      write   : in  std_logic;
      read    : in  std_logic;         
      addr    : in  std_logic_vector(4 downto 0);  
      rd_data : out std_logic_vector(31 downto 0);
      wr_data : in  std_logic_vector(31 downto 0);
      -- external signals 
      adc_p   : in  std_logic_vector(3 downto 0);
      adc_n   : in  std_logic_vector(3 downto 0)
   );
end chu_xadc_basys3_core;

architecture arch of chu_xadc_basys3_core is
   component xadc_fpro_basys3
   port (
      di_in : in std_logic_vector(15 downto 0);
      daddr_in : in std_logic_vector(6 downto 0);
      den_in : in std_logic;
      dwe_in : in std_logic;
      drdy_out : out std_logic;
      do_out : out std_logic_vector(15 downto 0);
      dclk_in : in std_logic;
      reset_in : in std_logic;
      vp_in : in std_logic;
      vn_in : in std_logic;
      vauxp6 : in std_logic;
      vauxn6 : in std_logic;
      vauxp7 : in std_logic;
      vauxn7 : in std_logic;
      vauxp14 : in std_logic;
      vauxn14 : in std_logic;
      vauxp15 : in std_logic;
      vauxn15 : in std_logic;
      channel_out : out std_logic_vector(4 downto 0);
      eoc_out : out std_logic;
      alarm_out : out std_logic;
      eos_out : out std_logic;
      busy_out : out std_logic
   );
   end component;
   signal channel      : std_logic_vector(4 downto 0);
   signal daddr_in     : std_logic_vector(6 downto 0);
   signal eoc          : std_logic;
   signal rdy          : std_logic;
   signal adc_data     : std_logic_vector(15 downto 0);
   signal adc0_out_reg : std_logic_vector(15 downto 0);
   signal adc1_out_reg : std_logic_vector(15 downto 0);
   signal adc2_out_reg : std_logic_vector(15 downto 0);
   signal adc3_out_reg : std_logic_vector(15 downto 0);
   signal tmp_out_reg  : std_logic_vector(15 downto 0);
   signal vcc_out_reg  : std_logic_vector(15 downto 0);
begin
   -- instantiate cusomized xadc core  
   xdac_unit : xadc_fpro_basys3
      port map(
         dclk_in     => clk,
         reset_in    => reset,          --reset,
         di_in       => (others => '0'),
         daddr_in    => daddr_in,
         den_in      => eoc,
         dwe_in      => '0',            -- read only
         drdy_out    => rdy,
         do_out      => adc_data,
         vp_in       => '0',
         vn_in       => '0',
         vauxp6      => adc_p(0),
         vauxn6      => adc_n(0),
         vauxp7      => adc_p(2),
         vauxn7      => adc_n(2),
         vauxp14     => adc_p(1),
         vauxn14     => adc_n(1),
         vauxp15     => adc_p(3),
         vauxn15     => adc_n(3),
         channel_out => channel,
         eoc_out     => eoc,
         eos_out     => open,
         busy_out    => open,
         alarm_out   => open
      );
   -- form xadc DRP address 
   daddr_in <= "00" & channel;
   -- registers and decoding 
   process(clk, reset)
   begin
      if reset = '1' then
         adc0_out_reg <= (others => '0');
         adc1_out_reg <= (others => '0');
         adc2_out_reg <= (others => '0');
         adc3_out_reg <= (others => '0');
         tmp_out_reg  <= (others => '0');
         vcc_out_reg  <= (others => '0');
      elsif (clk'event and clk = '1') then
         if rdy = '1' and channel = "10110" then
            adc0_out_reg <= adc_data;
         end if;
         if rdy = '1' and channel = "11110" then
            adc1_out_reg <= adc_data;
         end if;
         if rdy = '1' and channel = "10111" then
            adc2_out_reg <= adc_data;
         end if;
         if rdy = '1' and channel = "11111" then
            adc3_out_reg <= adc_data;
         end if;
         if rdy = '1' and channel = "00000" then
            tmp_out_reg <= adc_data;
         end if;
         if rdy = '1' and channel = "00001" then
            vcc_out_reg <= adc_data;
         end if;
      end if;
   end process;
   -- read multiplexing   
   with addr(2 downto 0) select 
      rd_data <=
         x"0000" & adc0_out_reg when "000",
         x"0000" & adc1_out_reg when "001",
         x"0000" & adc2_out_reg when "010",
         x"0000" & adc3_out_reg when "011",
         x"0000" & tmp_out_reg  when "100",
         x"0000" & vcc_out_reg  when others;
end arch;

