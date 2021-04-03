library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity chu_ps2_core is
   generic(W_SIZE : integer := 8);   -- 2^W_SIZE words in FIFO
   port(
      clk     : in std_logic;
      reset   : in std_logic;
      -- slot interface
      cs      : in std_logic;
      write   : in std_logic;
      read    : in std_logic;
      addr    : in std_logic_vector(4 downto 0);
      rd_data : out std_logic_vector(31 downto 0);
      wr_data : in std_logic_vector(31 downto 0);
      -- external signals
      ps2d    : inout std_logic;
      ps2c    : inout std_logic
   );
end chu_ps2_core;

architecture arch of chu_ps2_core is
   signal ps2_rx_data      : std_logic_vector(7 downto 0);
   signal wr_en, wr_ps2    : std_logic;
   signal rd_fifo          : std_logic;
   signal ps2_rx_buf_empty : std_logic;
   signal ps2_tx_idle      : std_logic;
begin
   -- instantiation
   ps2_unit : entity work.ps2_top
      generic map(W_SIZE => W_SIZE)
      port map(
         clk              => clk,
         reset            => reset,
         ps2d             => ps2d,
         ps2c             => ps2c,
         wr_ps2           => wr_ps2,
         rd_ps2_packet    => rd_fifo,
         ps2_tx_data      => wr_data(7 downto 0),
         ps2_rx_data      => ps2_rx_data,
         ps2_tx_idle      => ps2_tx_idle,
         ps2_rx_buf_empty => ps2_rx_buf_empty
      );
   -- decoding logic
   wr_en   <= '1' when cs='1' and write='1' else '0';
   wr_ps2  <= '1' when wr_en='1' and addr(1 downto 0)="10" else '0';
   rd_fifo <= '1' when wr_en='1' and addr(1 downto 0)="11" else '0';
   -- read 
   rd_data <= x"00000"&"00"& ps2_tx_idle & ps2_rx_buf_empty & ps2_rx_data;
end arch;
