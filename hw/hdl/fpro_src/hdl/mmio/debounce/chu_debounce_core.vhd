library ieee;
use ieee.std_logic_1164.all;
entity chu_debounce_core is
   generic(
      W : integer := 8;    -- width of input port
      N : integer := 20    -- # bit for 10-ms tick 2^N * clk period
   );
   port(clk     : in  std_logic;
        reset   : in  std_logic;
        -- io bridge interface
        cs      : in  std_logic;
        write   : in  std_logic;
        read    : in  std_logic;
        addr    : in  std_logic_vector(4 downto 0);
        rd_data : out std_logic_vector(31 downto 0);
        wr_data : in  std_logic_vector(31 downto 0);
        -- external signal
        din     : in  std_logic_vector(W-1 downto 0));
end chu_debounce_core;

architecture arch of chu_debounce_core is
   signal rd_data_reg : std_logic_vector(W-1 downto 0);
   signal m_tick      : std_logic;
   signal db_out      : std_logic_vector(W-1 downto 0);
begin
   --******************************************************************
   -- input register
   --******************************************************************
   process(clk, reset)
   begin
      if reset = '1' then
         rd_data_reg <= (others => '0');
      elsif (clk'event and clk = '1') then
         rd_data_reg <= din;
      end if;
   end process;
   --******************************************************************
   -- instantiate one counter and W debouncing FSMs
   --******************************************************************
   db_counter_unit : entity work.debounce_counter
      generic map(N => N)
      port map(
         clk    => clk,
         reset  => reset,
         m_tick => m_tick
      );
   gen_fsm_cell : for i in 0 to W-1 generate
      db_fsm_unit : entity work.debounce_fsm
         port map(
            clk    => clk,
            reset  => reset,
            sw     => din(i),
            m_tick => m_tick,
            db     => db_out(i)
         );
   end generate;
   --******************************************************************
   -- read multiplexing   
   --******************************************************************
   rd_data(W-1 downto 0) <= rd_data_reg when addr(0)='0' else db_out;
   rd_data(31 downto W)  <= (others => '0');
end arch;
