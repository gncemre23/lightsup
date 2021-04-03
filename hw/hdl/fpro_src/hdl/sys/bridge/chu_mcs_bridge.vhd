library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.chu_io_map.all;
entity chu_mcs_bridge is
   generic(BRG_BASE : std_logic_vector(31 downto 0) := x"C0000000");
   port(
      -- uBlaze MCS I/O bus
      io_addr_strobe  : in  std_logic;  -- not used 
      io_read_strobe  : in  std_logic;
      io_write_strobe : in  std_logic;
      io_byte_enable  : in  std_logic_vector(3 downto 0);
      io_address      : in  std_logic_vector(31 downto 0);
      io_write_data   : in  std_logic_vector(31 downto 0);
      io_read_data    : out std_logic_vector(31 downto 0);
      io_ready        : out std_logic;
      -- FPro bus
      fp_video_cs     : out std_logic;
      fp_mmio_cs      : out std_logic;
      fp_wr           : out std_logic;
      fp_rd           : out std_logic;
      fp_addr         : out std_logic_vector(20 downto 0);
      fp_wr_data      : out std_logic_vector(31 downto 0);
      fp_rd_data      : in  std_logic_vector(31 downto 0)
   );
end chu_mcs_bridge;

architecture arch of chu_mcs_bridge is
   signal mcs_bridge_en : std_logic;
   signal word_addr     : std_logic_vector(29 downto 0);
begin
   -- address translation and decoding
   -- 2 LSBs are "00" due to word alignment
   word_addr     <= io_address(31 downto 2);
   mcs_bridge_en <= 
      '1' when io_address(31 downto 24)=BRG_BASE(31 downto 24) else '0';
   fp_video_cs   <= 
      '1' when mcs_bridge_en='1' and io_address(23)='1' else '0';
   fp_mmio_cs    <= 
      '1' when mcs_bridge_en='1' and io_address(23)='0' else '0';
   fp_addr       <= word_addr(20 downto 0);
   -- control line conversion 
   fp_wr         <= io_write_strobe;
   fp_rd         <= io_read_strobe;
   io_ready      <= '1'; -- not used; transaction done in 1 clock
   -- data line conversion
   fp_wr_data    <= io_write_data;
   io_read_data  <= fp_rd_data;
end arch;

