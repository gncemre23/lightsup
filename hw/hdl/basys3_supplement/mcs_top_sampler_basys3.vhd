-- ********************************************************************
-- Revised for the Basys3 board
-- ********************************************************************
--  * reset_n removed since basys3 does not have dedicated reset pin;
--    if desired, a nomal buuton can be assigned
--  * mmio_sys_sampler_basys3 used to accomodate xadc_fpro_basys3
--  * an of 7-segment LED reduced from 8 bits to 4 bits (i.e., 4 digits)
--  * remove tr-color led/i2c/spi/audio ports
--  * pmod ja/jb/jc
--      * ja top: same as nexys; ja bottom: pwm93 downto 0)
--      * jb: pmod spi 
--      * jc top: i2c;  jc bottom: PmodAMP2
-- ********************************************************************
library ieee;
use ieee.std_logic_1164.all;
use work.chu_io_map.all;
entity mcs_top_sampler_basys3 is
   generic(BRIDGE_BASE : std_logic_vector(31 downto 0) := x"C0000000");
   port(
      clk         : in    std_logic;
      --reset       : in    std_logic;
      -- reset_n     : in    std_logic;
      -- switches and LEDs
      sw          : in    std_logic_vector(15 downto 0);
      led         : out   std_logic_vector(15 downto 0);
      -- uart
      rx          : in    std_logic;
      tx          : out   std_logic;
      -- xadc
      adc_p       : in    std_logic_vector(3 downto 0);
      adc_n       : in    std_logic_vector(3 downto 0);
      -- rgb leds
      -- rgb_led1    : out   std_logic_vector(2 downto 0);
      -- rgb_led2    : out   std_logic_vector(2 downto 0);
      -- buttons
      btn         : in    std_logic_vector(4 downto 0);
      -- 4-digit 7-seg LEDs
      sseg        : out   std_logic_vector(7 downto 0);
      --an          : out   std_logic_vector(7 downto 0);
      an          : out   std_logic_vector(3 downto 0);
      -- spi accelerator
      -- acl_sclk    : out   std_logic;
      -- acl_mosi    : out   std_logic;
      -- acl_miso    : in    std_logic;
      -- acl_ss_n    : out   std_logic;
      -- i2c temperature sensor
      -- tmp_i2c_scl : out   std_logic;
      -- tmp_i2c_sda : inout std_logic;
      -- ps2
      ps2d        : inout std_logic;
      ps2c        : inout std_logic;
      -- nexsys 4 aduio
      -- audio_on    : out   std_logic;
      -- audio_pdm   : out   std_logic;
      -- PMOD JA (divided into top row and bottom row
      ja_top      : out   std_logic_vector(4 downto 1);
      ja_btm      : out   std_logic_vector(10 downto 7);
      -- PMOD JB (divided into top row and bottom row
      jb_top      : inout   std_logic_vector(4 downto 1);
      jb_btm      : inout   std_logic_vector(10 downto 7);
      -- PMOD JC (divided into top row and bottom row
      jc_top      : inout   std_logic_vector(4 downto 1);
      jc_btm      : inout   std_logic_vector(10 downto 7)
   );
end mcs_top_sampler_basys3;

architecture arch of mcs_top_sampler_basys3 is
   component cpu
      port(
         clk             : in  std_logic;
         reset           : in  std_logic;
         io_addr_strobe  : out std_logic;
         io_read_strobe  : out std_logic;
         io_write_strobe : out std_logic;
         io_address      : out std_logic_vector(31 downto 0);
         io_byte_enable  : out std_logic_vector(3 downto 0);
         io_write_data   : out std_logic_vector(31 downto 0);
         io_read_data    : in  std_logic_vector(31 downto 0);
         io_ready        : in  std_logic
      );
   end component;
   signal io_addr_strobe  : std_logic;
   signal io_read_strobe  : std_logic;
   signal io_write_strobe : std_logic;
   signal io_byte_enable  : std_logic_vector(3 downto 0);
   signal io_address      : std_logic_vector(31 downto 0);
   signal io_write_data   : std_logic_vector(31 downto 0);
   signal io_read_data    : std_logic_vector(31 downto 0);
   signal io_ready        : std_logic;
   signal mmio_cs         : std_logic;
   signal mmio_wr         : std_logic;
   signal mmio_rd         : std_logic;
   signal mmio_addr       : std_logic_vector(20 downto 0);
   signal mmio_wr_data    : std_logic_vector(31 downto 0);
   signal mmio_rd_data    : std_logic_vector(31 downto 0);
   -- clk/reset related
   signal clk_100M        : std_logic;
   signal reset_sys       : std_logic;
   -- pwm 
   signal pwm             : std_logic_vector(7 downto 0);
   -- ddfs/audio pdm 
   signal pdm             : std_logic;
   signal ddfs_sq_wave    : std_logic;
   -- new intermediate signals for basys3
   signal an8         : std_logic_vector(7 downto 0);
   signal acl_sclk    : std_logic;
   signal acl_mosi    : std_logic;
   signal acl_miso    : std_logic;
   signal acl_ss_n    : std_logic;
   signal tmp_i2c_scl : std_logic;
   signal tmp_i2c_sda : std_logic;
   
   
begin
   -- clock and reset
   clk_100M           <= clk;           -- 100 MHz external clock
   reset_sys          <= '0';
   --reset_sys          <= not reset_n;
   -- audio
   -- audio_pdm          <= pdm;
   -- audio_on           <= '1';
   -- rgb leds
   -- rgb_led2           <= pwm(5 downto 3);
   -- rgb_led1           <= pwm(2 downto 0);
   -- PMOD JA  
   ja_top(1)          <= ddfs_sq_wave;
   ja_top(2)          <= pdm;
   ja_top(4 downto 3) <= pwm(7 downto 6);
   ja_btm             <= pwm(3 downto 0);
   --====================================================
   -- basys3 reconnection 
   --====================================================
   an <= an8(3 downto 0);
   -- PMOD JB: pmod spi 
   jb_top(1) <= acl_ss_n; --  ss_n 
   jb_top(2) <= acl_mosi; --  mosi
   acl_miso <= jb_top(3); --  miso 
   jb_top(4) <= acl_sclk; --  sclk 
   -- PMOD JC: pmod i2c 
   -- jc_top(1) mapped to sda in port mapping 
   jc_top(2) <= tmp_i2c_scl; -- scl
   -- bottom fpo PMOD AMP2 (audio amplifier).
   jc_btm(7) <= pdm;
   jc_btm(8) <= '0'; -- 12 db (high) gain  
   jc_btm(10) <= '1'; -- 0 to shut down audio amp  
  
   -- instantiate microBlaze MCS
   mcs_0 : cpu
      port map(
         clk             => clk_100M,
         reset           => reset_sys,
         io_addr_strobe  => io_addr_strobe,
         io_read_strobe  => io_read_strobe,
         io_write_strobe => io_write_strobe,
         io_byte_enable  => io_byte_enable,
         io_address      => io_address,
         io_write_data   => io_write_data,
         io_read_data    => io_read_data,
         io_ready        => io_ready
      );
   -- instantiate MCS IO bus to FPro bus bridge
   bridge_unit : entity work.chu_mcs_bridge
      generic map(BRG_BASE => BRIDGE_BASE)
      port map(
         io_addr_strobe  => io_addr_strobe,
         io_read_strobe  => io_read_strobe,
         io_write_strobe => io_write_strobe,
         io_byte_enable  => io_byte_enable,
         io_address      => io_address,
         io_write_data   => io_write_data,
         io_read_data    => io_read_data,
         io_ready        => io_ready,
         fp_video_cs     => open,
         fp_mmio_cs      => mmio_cs,
         fp_wr           => mmio_wr,
         fp_rd           => mmio_rd,
         fp_addr         => mmio_addr,
         fp_wr_data      => mmio_wr_data,
         fp_rd_data      => mmio_rd_data
      );
   -- instantiate sampler MMIO subsystem 
   mmio_sys_unit : entity work.mmio_sys_sampler_basys3
      port map(
         clk          => clk_100M,
         reset        => reset_sys,
         mmio_cs      => mmio_cs,
         mmio_wr      => mmio_wr,
         mmio_rd      => mmio_rd,
         mmio_addr    => mmio_addr,
         mmio_wr_data => mmio_wr_data,
         mmio_rd_data => mmio_rd_data,
         sw           => sw,
         led          => led,
         rx           => rx,
         tx           => tx,
         adc_p        => adc_p,
         adc_n        => adc_n,
         pwm          => pwm,
         btn          => btn,
         an           => an8,
         sseg         => sseg,
         tmp_i2c_scl  => tmp_i2c_scl,
         tmp_i2c_sda  => jc_top(1), --tmp_i2c_sda,
         acl_sclk     => acl_sclk,
         acl_mosi     => acl_mosi,
         acl_miso     => acl_miso,
         acl_ss       => acl_ss_n,
         ps2d         => ps2d,
         ps2c         => ps2c,
         ddfs_sq_wave => ddfs_sq_wave,
         pdm          => pdm
      );
end arch;

