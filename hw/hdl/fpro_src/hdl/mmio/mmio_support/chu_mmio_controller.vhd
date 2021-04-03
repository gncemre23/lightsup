library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.chu_io_map.all;
entity chu_mmio_controller is
   port(
      -- FPro bus 
      mmio_cs             : in  std_logic;
      mmio_wr             : in  std_logic;
      mmio_rd             : in  std_logic;
      mmio_addr           : in  std_logic_vector(20 downto 0);
      mmio_wr_data        : in  std_logic_vector(31 downto 0);
      mmio_rd_data        : out std_logic_vector(31 downto 0);
      -- slot interface
      slot_cs_array       : out std_logic_vector(63 downto 0);
      slot_mem_rd_array   : out std_logic_vector(63 downto 0);
      slot_mem_wr_array   : out std_logic_vector(63 downto 0);
      slot_reg_addr_array : out slot_2d_reg_type;
      slot_rd_data_array  : in  slot_2d_data_type;
      slot_wr_data_array  : out slot_2d_data_type
   );
end chu_mmio_controller;

architecture arch of chu_mmio_controller is
   -- 11 LSBs of address used; 2^6 slots, each with 2^5 registers
   alias slot_addr : std_logic_vector(5 downto 0) is 
         mmio_addr(10 downto 5);
   alias reg_addr  : std_logic_vector(4 downto 0) is 
         mmio_addr(4 downto 0);
begin
   -- address decoding
      process(slot_addr, mmio_cs)
   begin
      slot_cs_array <= (others => '0');
      if mmio_cs = '1' then
         slot_cs_array(to_integer(unsigned(slot_addr))) <= '1';
      end if;
   end process;
   -- broadcast to all slots 
   slot_mem_rd_array   <= (others => mmio_rd);
   slot_mem_wr_array   <= (others => mmio_wr);
   slot_wr_data_array  <= (others => mmio_wr_data);
   slot_reg_addr_array <= (others => reg_addr);
   -- mux for read data 
   mmio_rd_data <= slot_rd_data_array(to_integer(unsigned(slot_addr)));
end arch;

