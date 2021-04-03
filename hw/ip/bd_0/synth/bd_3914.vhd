--Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Command: generate_target bd_3914.bd
--Design : bd_3914
--Purpose: IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity bd_3914 is
  port (
    Clk : in STD_LOGIC;
    IO_addr_strobe : out STD_LOGIC;
    IO_address : out STD_LOGIC_VECTOR ( 31 downto 0 );
    IO_byte_enable : out STD_LOGIC_VECTOR ( 3 downto 0 );
    IO_read_data : in STD_LOGIC_VECTOR ( 31 downto 0 );
    IO_read_strobe : out STD_LOGIC;
    IO_ready : in STD_LOGIC;
    IO_write_data : out STD_LOGIC_VECTOR ( 31 downto 0 );
    IO_write_strobe : out STD_LOGIC;
    Reset : in STD_LOGIC
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of bd_3914 : entity is "bd_3914,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=bd_3914,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=10,numReposBlks=10,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=SBD,synth_mode=OOC_per_IP}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of bd_3914 : entity is "cpu.hwdef";
end bd_3914;

architecture STRUCTURE of bd_3914 is
  component bd_3914_microblaze_I_0 is
  port (
    Clk : in STD_LOGIC;
    Reset : in STD_LOGIC;
    Interrupt : in STD_LOGIC;
    Interrupt_Address : in STD_LOGIC_VECTOR ( 0 to 31 );
    Interrupt_Ack : out STD_LOGIC_VECTOR ( 0 to 1 );
    Ext_BRK : in STD_LOGIC;
    Ext_NM_BRK : in STD_LOGIC;
    Dbg_Stop : in STD_LOGIC;
    MB_Halted : out STD_LOGIC;
    Wakeup : in STD_LOGIC_VECTOR ( 0 to 1 );
    Sleep : out STD_LOGIC;
    Hibernate : out STD_LOGIC;
    Suspend : out STD_LOGIC;
    Dbg_Wakeup : out STD_LOGIC;
    Dbg_Continue : out STD_LOGIC;
    Reset_Mode : in STD_LOGIC_VECTOR ( 0 to 1 );
    Pause : in STD_LOGIC;
    Pause_Ack : out STD_LOGIC;
    Non_Secure : in STD_LOGIC_VECTOR ( 0 to 3 );
    Instr_Addr : out STD_LOGIC_VECTOR ( 0 to 31 );
    Instr : in STD_LOGIC_VECTOR ( 0 to 31 );
    IFetch : out STD_LOGIC;
    I_AS : out STD_LOGIC;
    IReady : in STD_LOGIC;
    IWAIT : in STD_LOGIC;
    ICE : in STD_LOGIC;
    IUE : in STD_LOGIC;
    Data_Addr : out STD_LOGIC_VECTOR ( 0 to 31 );
    Data_Read : in STD_LOGIC_VECTOR ( 0 to 31 );
    Data_Write : out STD_LOGIC_VECTOR ( 0 to 31 );
    D_AS : out STD_LOGIC;
    Read_Strobe : out STD_LOGIC;
    Write_Strobe : out STD_LOGIC;
    DReady : in STD_LOGIC;
    DWait : in STD_LOGIC;
    DCE : in STD_LOGIC;
    DUE : in STD_LOGIC;
    Byte_Enable : out STD_LOGIC_VECTOR ( 0 to 3 );
    Dbg_Clk : in STD_LOGIC;
    Dbg_TDI : in STD_LOGIC;
    Dbg_TDO : out STD_LOGIC;
    Dbg_Reg_En : in STD_LOGIC_VECTOR ( 0 to 7 );
    Dbg_Shift : in STD_LOGIC;
    Dbg_Capture : in STD_LOGIC;
    Dbg_Update : in STD_LOGIC;
    Debug_Rst : in STD_LOGIC;
    Dbg_Disable : in STD_LOGIC
  );
  end component bd_3914_microblaze_I_0;
  component bd_3914_rst_0_0 is
  port (
    slowest_sync_clk : in STD_LOGIC;
    ext_reset_in : in STD_LOGIC;
    aux_reset_in : in STD_LOGIC;
    mb_debug_sys_rst : in STD_LOGIC;
    dcm_locked : in STD_LOGIC;
    mb_reset : out STD_LOGIC;
    bus_struct_reset : out STD_LOGIC_VECTOR ( 0 to 0 );
    peripheral_reset : out STD_LOGIC_VECTOR ( 0 to 0 );
    interconnect_aresetn : out STD_LOGIC_VECTOR ( 0 to 0 );
    peripheral_aresetn : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component bd_3914_rst_0_0;
  component bd_3914_ilmb_0 is
  port (
    LMB_Clk : in STD_LOGIC;
    SYS_Rst : in STD_LOGIC;
    LMB_Rst : out STD_LOGIC;
    M_ABus : in STD_LOGIC_VECTOR ( 0 to 31 );
    M_ReadStrobe : in STD_LOGIC;
    M_WriteStrobe : in STD_LOGIC;
    M_AddrStrobe : in STD_LOGIC;
    M_DBus : in STD_LOGIC_VECTOR ( 0 to 31 );
    M_BE : in STD_LOGIC_VECTOR ( 0 to 3 );
    Sl_DBus : in STD_LOGIC_VECTOR ( 0 to 31 );
    Sl_Ready : in STD_LOGIC_VECTOR ( 0 to 0 );
    Sl_Wait : in STD_LOGIC_VECTOR ( 0 to 0 );
    Sl_UE : in STD_LOGIC_VECTOR ( 0 to 0 );
    Sl_CE : in STD_LOGIC_VECTOR ( 0 to 0 );
    LMB_ABus : out STD_LOGIC_VECTOR ( 0 to 31 );
    LMB_ReadStrobe : out STD_LOGIC;
    LMB_WriteStrobe : out STD_LOGIC;
    LMB_AddrStrobe : out STD_LOGIC;
    LMB_ReadDBus : out STD_LOGIC_VECTOR ( 0 to 31 );
    LMB_WriteDBus : out STD_LOGIC_VECTOR ( 0 to 31 );
    LMB_Ready : out STD_LOGIC;
    LMB_Wait : out STD_LOGIC;
    LMB_UE : out STD_LOGIC;
    LMB_CE : out STD_LOGIC;
    LMB_BE : out STD_LOGIC_VECTOR ( 0 to 3 )
  );
  end component bd_3914_ilmb_0;
  component bd_3914_dlmb_0 is
  port (
    LMB_Clk : in STD_LOGIC;
    SYS_Rst : in STD_LOGIC;
    LMB_Rst : out STD_LOGIC;
    M_ABus : in STD_LOGIC_VECTOR ( 0 to 31 );
    M_ReadStrobe : in STD_LOGIC;
    M_WriteStrobe : in STD_LOGIC;
    M_AddrStrobe : in STD_LOGIC;
    M_DBus : in STD_LOGIC_VECTOR ( 0 to 31 );
    M_BE : in STD_LOGIC_VECTOR ( 0 to 3 );
    Sl_DBus : in STD_LOGIC_VECTOR ( 0 to 63 );
    Sl_Ready : in STD_LOGIC_VECTOR ( 0 to 1 );
    Sl_Wait : in STD_LOGIC_VECTOR ( 0 to 1 );
    Sl_UE : in STD_LOGIC_VECTOR ( 0 to 1 );
    Sl_CE : in STD_LOGIC_VECTOR ( 0 to 1 );
    LMB_ABus : out STD_LOGIC_VECTOR ( 0 to 31 );
    LMB_ReadStrobe : out STD_LOGIC;
    LMB_WriteStrobe : out STD_LOGIC;
    LMB_AddrStrobe : out STD_LOGIC;
    LMB_ReadDBus : out STD_LOGIC_VECTOR ( 0 to 31 );
    LMB_WriteDBus : out STD_LOGIC_VECTOR ( 0 to 31 );
    LMB_Ready : out STD_LOGIC;
    LMB_Wait : out STD_LOGIC;
    LMB_UE : out STD_LOGIC;
    LMB_CE : out STD_LOGIC;
    LMB_BE : out STD_LOGIC_VECTOR ( 0 to 3 )
  );
  end component bd_3914_dlmb_0;
  component bd_3914_dlmb_cntlr_0 is
  port (
    LMB_Clk : in STD_LOGIC;
    LMB_Rst : in STD_LOGIC;
    LMB_ABus : in STD_LOGIC_VECTOR ( 0 to 31 );
    LMB_WriteDBus : in STD_LOGIC_VECTOR ( 0 to 31 );
    LMB_AddrStrobe : in STD_LOGIC;
    LMB_ReadStrobe : in STD_LOGIC;
    LMB_WriteStrobe : in STD_LOGIC;
    LMB_BE : in STD_LOGIC_VECTOR ( 0 to 3 );
    Sl_DBus : out STD_LOGIC_VECTOR ( 0 to 31 );
    Sl_Ready : out STD_LOGIC;
    Sl_Wait : out STD_LOGIC;
    Sl_UE : out STD_LOGIC;
    Sl_CE : out STD_LOGIC;
    BRAM_Rst_A : out STD_LOGIC;
    BRAM_Clk_A : out STD_LOGIC;
    BRAM_Addr_A : out STD_LOGIC_VECTOR ( 0 to 31 );
    BRAM_EN_A : out STD_LOGIC;
    BRAM_WEN_A : out STD_LOGIC_VECTOR ( 0 to 3 );
    BRAM_Dout_A : out STD_LOGIC_VECTOR ( 0 to 31 );
    BRAM_Din_A : in STD_LOGIC_VECTOR ( 0 to 31 )
  );
  end component bd_3914_dlmb_cntlr_0;
  component bd_3914_ilmb_cntlr_0 is
  port (
    LMB_Clk : in STD_LOGIC;
    LMB_Rst : in STD_LOGIC;
    LMB_ABus : in STD_LOGIC_VECTOR ( 0 to 31 );
    LMB_WriteDBus : in STD_LOGIC_VECTOR ( 0 to 31 );
    LMB_AddrStrobe : in STD_LOGIC;
    LMB_ReadStrobe : in STD_LOGIC;
    LMB_WriteStrobe : in STD_LOGIC;
    LMB_BE : in STD_LOGIC_VECTOR ( 0 to 3 );
    Sl_DBus : out STD_LOGIC_VECTOR ( 0 to 31 );
    Sl_Ready : out STD_LOGIC;
    Sl_Wait : out STD_LOGIC;
    Sl_UE : out STD_LOGIC;
    Sl_CE : out STD_LOGIC;
    BRAM_Rst_A : out STD_LOGIC;
    BRAM_Clk_A : out STD_LOGIC;
    BRAM_Addr_A : out STD_LOGIC_VECTOR ( 0 to 31 );
    BRAM_EN_A : out STD_LOGIC;
    BRAM_WEN_A : out STD_LOGIC_VECTOR ( 0 to 3 );
    BRAM_Dout_A : out STD_LOGIC_VECTOR ( 0 to 31 );
    BRAM_Din_A : in STD_LOGIC_VECTOR ( 0 to 31 )
  );
  end component bd_3914_ilmb_cntlr_0;
  component bd_3914_lmb_bram_I_0 is
  port (
    clka : in STD_LOGIC;
    rsta : in STD_LOGIC;
    ena : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 3 downto 0 );
    addra : in STD_LOGIC_VECTOR ( 31 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 31 downto 0 );
    douta : out STD_LOGIC_VECTOR ( 31 downto 0 );
    clkb : in STD_LOGIC;
    rstb : in STD_LOGIC;
    enb : in STD_LOGIC;
    web : in STD_LOGIC_VECTOR ( 3 downto 0 );
    addrb : in STD_LOGIC_VECTOR ( 31 downto 0 );
    dinb : in STD_LOGIC_VECTOR ( 31 downto 0 );
    doutb : out STD_LOGIC_VECTOR ( 31 downto 0 );
    rsta_busy : out STD_LOGIC;
    rstb_busy : out STD_LOGIC
  );
  end component bd_3914_lmb_bram_I_0;
  component bd_3914_mdm_0_0 is
  port (
    Debug_SYS_Rst : out STD_LOGIC;
    Dbg_Clk_0 : out STD_LOGIC;
    Dbg_TDI_0 : out STD_LOGIC;
    Dbg_TDO_0 : in STD_LOGIC;
    Dbg_Reg_En_0 : out STD_LOGIC_VECTOR ( 0 to 7 );
    Dbg_Capture_0 : out STD_LOGIC;
    Dbg_Shift_0 : out STD_LOGIC;
    Dbg_Update_0 : out STD_LOGIC;
    Dbg_Rst_0 : out STD_LOGIC;
    Dbg_Disable_0 : out STD_LOGIC
  );
  end component bd_3914_mdm_0_0;
  component bd_3914_xlconcat_0_0 is
  port (
    In0 : in STD_LOGIC_VECTOR ( 0 to 0 );
    In1 : in STD_LOGIC_VECTOR ( 0 to 0 );
    dout : out STD_LOGIC_VECTOR ( 1 downto 0 )
  );
  end component bd_3914_xlconcat_0_0;
  component bd_3914_iomodule_0_0 is
  port (
    Clk : in STD_LOGIC;
    Rst : in STD_LOGIC;
    IO_Addr_Strobe : out STD_LOGIC;
    IO_Read_Strobe : out STD_LOGIC;
    IO_Write_Strobe : out STD_LOGIC;
    IO_Address : out STD_LOGIC_VECTOR ( 31 downto 0 );
    IO_Byte_Enable : out STD_LOGIC_VECTOR ( 3 downto 0 );
    IO_Write_Data : out STD_LOGIC_VECTOR ( 31 downto 0 );
    IO_Read_Data : in STD_LOGIC_VECTOR ( 31 downto 0 );
    IO_Ready : in STD_LOGIC;
    LMB_ABus : in STD_LOGIC_VECTOR ( 0 to 31 );
    LMB_WriteDBus : in STD_LOGIC_VECTOR ( 0 to 31 );
    LMB_AddrStrobe : in STD_LOGIC;
    LMB_ReadStrobe : in STD_LOGIC;
    LMB_WriteStrobe : in STD_LOGIC;
    LMB_BE : in STD_LOGIC_VECTOR ( 0 to 3 );
    Sl_DBus : out STD_LOGIC_VECTOR ( 0 to 31 );
    Sl_Ready : out STD_LOGIC;
    Sl_Wait : out STD_LOGIC;
    Sl_UE : out STD_LOGIC;
    Sl_CE : out STD_LOGIC
  );
  end component bd_3914_iomodule_0_0;
  signal Clk1 : STD_LOGIC;
  signal Dbg_Wakeup : STD_LOGIC;
  signal Debug_SYS_Rst : STD_LOGIC;
  signal IO_Rst : STD_LOGIC_VECTOR ( 0 to 0 );
  signal LMB_Rst1 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal MB_Reset : STD_LOGIC;
  signal Wakeup : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal dlmb_ABUS : STD_LOGIC_VECTOR ( 0 to 31 );
  signal dlmb_ADDRSTROBE : STD_LOGIC;
  signal dlmb_BE : STD_LOGIC_VECTOR ( 0 to 3 );
  signal dlmb_CE : STD_LOGIC;
  signal dlmb_READDBUS : STD_LOGIC_VECTOR ( 0 to 31 );
  signal dlmb_READSTROBE : STD_LOGIC;
  signal dlmb_READY : STD_LOGIC;
  signal dlmb_UE : STD_LOGIC;
  signal dlmb_WAIT : STD_LOGIC;
  signal dlmb_WRITEDBUS : STD_LOGIC_VECTOR ( 0 to 31 );
  signal dlmb_WRITESTROBE : STD_LOGIC;
  signal dlmb_port_ADDR : STD_LOGIC_VECTOR ( 0 to 31 );
  signal dlmb_port_CLK : STD_LOGIC;
  signal dlmb_port_DIN : STD_LOGIC_VECTOR ( 0 to 31 );
  signal dlmb_port_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal dlmb_port_EN : STD_LOGIC;
  signal dlmb_port_RST : STD_LOGIC;
  signal dlmb_port_WE : STD_LOGIC_VECTOR ( 0 to 3 );
  signal dlmb_sl_0_ABUS : STD_LOGIC_VECTOR ( 0 to 31 );
  signal dlmb_sl_0_ADDRSTROBE : STD_LOGIC;
  signal dlmb_sl_0_BE : STD_LOGIC_VECTOR ( 0 to 3 );
  signal dlmb_sl_0_CE : STD_LOGIC;
  signal dlmb_sl_0_READDBUS : STD_LOGIC_VECTOR ( 0 to 31 );
  signal dlmb_sl_0_READSTROBE : STD_LOGIC;
  signal dlmb_sl_0_READY : STD_LOGIC;
  signal dlmb_sl_0_UE : STD_LOGIC;
  signal dlmb_sl_0_WAIT : STD_LOGIC;
  signal dlmb_sl_0_WRITEDBUS : STD_LOGIC_VECTOR ( 0 to 31 );
  signal dlmb_sl_0_WRITESTROBE : STD_LOGIC;
  signal dlmb_sl_1_CE : STD_LOGIC;
  signal dlmb_sl_1_READDBUS : STD_LOGIC_VECTOR ( 0 to 31 );
  signal dlmb_sl_1_READY : STD_LOGIC;
  signal dlmb_sl_1_UE : STD_LOGIC;
  signal dlmb_sl_1_WAIT : STD_LOGIC;
  signal ilmb_ABUS : STD_LOGIC_VECTOR ( 0 to 31 );
  signal ilmb_ADDRSTROBE : STD_LOGIC;
  signal ilmb_CE : STD_LOGIC;
  signal ilmb_READDBUS : STD_LOGIC_VECTOR ( 0 to 31 );
  signal ilmb_READSTROBE : STD_LOGIC;
  signal ilmb_READY : STD_LOGIC;
  signal ilmb_UE : STD_LOGIC;
  signal ilmb_WAIT : STD_LOGIC;
  signal ilmb_port_ADDR : STD_LOGIC_VECTOR ( 0 to 31 );
  signal ilmb_port_CLK : STD_LOGIC;
  signal ilmb_port_DIN : STD_LOGIC_VECTOR ( 0 to 31 );
  signal ilmb_port_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal ilmb_port_EN : STD_LOGIC;
  signal ilmb_port_RST : STD_LOGIC;
  signal ilmb_port_WE : STD_LOGIC_VECTOR ( 0 to 3 );
  signal ilmb_sl_0_ABUS : STD_LOGIC_VECTOR ( 0 to 31 );
  signal ilmb_sl_0_ADDRSTROBE : STD_LOGIC;
  signal ilmb_sl_0_BE : STD_LOGIC_VECTOR ( 0 to 3 );
  signal ilmb_sl_0_CE : STD_LOGIC;
  signal ilmb_sl_0_READDBUS : STD_LOGIC_VECTOR ( 0 to 31 );
  signal ilmb_sl_0_READSTROBE : STD_LOGIC;
  signal ilmb_sl_0_READY : STD_LOGIC;
  signal ilmb_sl_0_UE : STD_LOGIC;
  signal ilmb_sl_0_WAIT : STD_LOGIC;
  signal ilmb_sl_0_WRITEDBUS : STD_LOGIC_VECTOR ( 0 to 31 );
  signal ilmb_sl_0_WRITESTROBE : STD_LOGIC;
  signal iomodule_0_IO_ADDRESS : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal iomodule_0_IO_ADDR_STROBE : STD_LOGIC;
  signal iomodule_0_IO_BYTE_ENABLE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal iomodule_0_IO_READY : STD_LOGIC;
  signal iomodule_0_IO_READ_DATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal iomodule_0_IO_READ_STROBE : STD_LOGIC;
  signal iomodule_0_IO_WRITE_DATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal iomodule_0_IO_WRITE_STROBE : STD_LOGIC;
  signal microblaze_I_mdm_bus_CAPTURE : STD_LOGIC;
  signal microblaze_I_mdm_bus_CLK : STD_LOGIC;
  signal microblaze_I_mdm_bus_DISABLE : STD_LOGIC;
  signal microblaze_I_mdm_bus_REG_EN : STD_LOGIC_VECTOR ( 0 to 7 );
  signal microblaze_I_mdm_bus_RST : STD_LOGIC;
  signal microblaze_I_mdm_bus_SHIFT : STD_LOGIC;
  signal microblaze_I_mdm_bus_TDI : STD_LOGIC;
  signal microblaze_I_mdm_bus_TDO : STD_LOGIC;
  signal microblaze_I_mdm_bus_UPDATE : STD_LOGIC;
  signal NLW_dlmb_LMB_Rst_UNCONNECTED : STD_LOGIC;
  signal NLW_ilmb_LMB_Rst_UNCONNECTED : STD_LOGIC;
  signal NLW_lmb_bram_I_rsta_busy_UNCONNECTED : STD_LOGIC;
  signal NLW_lmb_bram_I_rstb_busy_UNCONNECTED : STD_LOGIC;
  signal NLW_microblaze_I_Dbg_Continue_UNCONNECTED : STD_LOGIC;
  signal NLW_microblaze_I_Hibernate_UNCONNECTED : STD_LOGIC;
  signal NLW_microblaze_I_MB_Halted_UNCONNECTED : STD_LOGIC;
  signal NLW_microblaze_I_Pause_Ack_UNCONNECTED : STD_LOGIC;
  signal NLW_microblaze_I_Sleep_UNCONNECTED : STD_LOGIC;
  signal NLW_microblaze_I_Suspend_UNCONNECTED : STD_LOGIC;
  signal NLW_microblaze_I_Interrupt_Ack_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 1 );
  signal NLW_rst_0_interconnect_aresetn_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_rst_0_peripheral_aresetn_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  attribute BMM_INFO_ADDRESS_SPACE : string;
  attribute BMM_INFO_ADDRESS_SPACE of dlmb_cntlr : label is "byte  0x00000000 32 > bd_3914 lmb_bram_I";
  attribute KEEP_HIERARCHY : string;
  attribute KEEP_HIERARCHY of dlmb_cntlr : label is "yes";
  attribute BMM_INFO_PROCESSOR : string;
  attribute BMM_INFO_PROCESSOR of microblaze_I : label is "microblaze-le > bd_3914 dlmb_cntlr";
  attribute KEEP_HIERARCHY of microblaze_I : label is "yes";
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of Clk : signal is "xilinx.com:signal:clock:1.0 CLK.CLK CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of Clk : signal is "XIL_INTERFACENAME CLK.CLK, ASSOCIATED_ASYNC_RESET Reset, CLK_DOMAIN bd_3914_Clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.000";
  attribute X_INTERFACE_INFO of IO_addr_strobe : signal is "xilinx.com:interface:mcsio_bus:1.0 IO ADDR_STROBE";
  attribute X_INTERFACE_INFO of IO_read_strobe : signal is "xilinx.com:interface:mcsio_bus:1.0 IO READ_STROBE";
  attribute X_INTERFACE_INFO of IO_ready : signal is "xilinx.com:interface:mcsio_bus:1.0 IO READY";
  attribute X_INTERFACE_INFO of IO_write_strobe : signal is "xilinx.com:interface:mcsio_bus:1.0 IO WRITE_STROBE";
  attribute X_INTERFACE_INFO of Reset : signal is "xilinx.com:signal:reset:1.0 RST.RESET RST";
  attribute X_INTERFACE_PARAMETER of Reset : signal is "XIL_INTERFACENAME RST.RESET, INSERT_VIP 0, POLARITY ACTIVE_HIGH";
  attribute X_INTERFACE_INFO of IO_address : signal is "xilinx.com:interface:mcsio_bus:1.0 IO ADDRESS";
  attribute X_INTERFACE_INFO of IO_byte_enable : signal is "xilinx.com:interface:mcsio_bus:1.0 IO BYTE_ENABLE";
  attribute X_INTERFACE_INFO of IO_read_data : signal is "xilinx.com:interface:mcsio_bus:1.0 IO READ_DATA";
  attribute X_INTERFACE_INFO of IO_write_data : signal is "xilinx.com:interface:mcsio_bus:1.0 IO WRITE_DATA";
begin
  Clk1 <= Clk;
  IO_addr_strobe <= iomodule_0_IO_ADDR_STROBE;
  IO_address(31 downto 0) <= iomodule_0_IO_ADDRESS(31 downto 0);
  IO_byte_enable(3 downto 0) <= iomodule_0_IO_BYTE_ENABLE(3 downto 0);
  IO_read_strobe <= iomodule_0_IO_READ_STROBE;
  IO_write_data(31 downto 0) <= iomodule_0_IO_WRITE_DATA(31 downto 0);
  IO_write_strobe <= iomodule_0_IO_WRITE_STROBE;
  iomodule_0_IO_READY <= IO_ready;
  iomodule_0_IO_READ_DATA(31 downto 0) <= IO_read_data(31 downto 0);
dlmb: component bd_3914_dlmb_0
     port map (
      LMB_ABus(0 to 31) => dlmb_sl_0_ABUS(0 to 31),
      LMB_AddrStrobe => dlmb_sl_0_ADDRSTROBE,
      LMB_BE(0 to 3) => dlmb_sl_0_BE(0 to 3),
      LMB_CE => dlmb_CE,
      LMB_Clk => Clk1,
      LMB_ReadDBus(0 to 31) => dlmb_READDBUS(0 to 31),
      LMB_ReadStrobe => dlmb_sl_0_READSTROBE,
      LMB_Ready => dlmb_READY,
      LMB_Rst => NLW_dlmb_LMB_Rst_UNCONNECTED,
      LMB_UE => dlmb_UE,
      LMB_Wait => dlmb_WAIT,
      LMB_WriteDBus(0 to 31) => dlmb_sl_0_WRITEDBUS(0 to 31),
      LMB_WriteStrobe => dlmb_sl_0_WRITESTROBE,
      M_ABus(0 to 31) => dlmb_ABUS(0 to 31),
      M_AddrStrobe => dlmb_ADDRSTROBE,
      M_BE(0 to 3) => dlmb_BE(0 to 3),
      M_DBus(0 to 31) => dlmb_WRITEDBUS(0 to 31),
      M_ReadStrobe => dlmb_READSTROBE,
      M_WriteStrobe => dlmb_WRITESTROBE,
      SYS_Rst => LMB_Rst1(0),
      Sl_CE(0) => dlmb_sl_0_CE,
      Sl_CE(1) => dlmb_sl_1_CE,
      Sl_DBus(0 to 31) => dlmb_sl_0_READDBUS(0 to 31),
      Sl_DBus(32 to 63) => dlmb_sl_1_READDBUS(0 to 31),
      Sl_Ready(0) => dlmb_sl_0_READY,
      Sl_Ready(1) => dlmb_sl_1_READY,
      Sl_UE(0) => dlmb_sl_0_UE,
      Sl_UE(1) => dlmb_sl_1_UE,
      Sl_Wait(0) => dlmb_sl_0_WAIT,
      Sl_Wait(1) => dlmb_sl_1_WAIT
    );
dlmb_cntlr: component bd_3914_dlmb_cntlr_0
     port map (
      BRAM_Addr_A(0 to 31) => dlmb_port_ADDR(0 to 31),
      BRAM_Clk_A => dlmb_port_CLK,
      BRAM_Din_A(0) => dlmb_port_DOUT(31),
      BRAM_Din_A(1) => dlmb_port_DOUT(30),
      BRAM_Din_A(2) => dlmb_port_DOUT(29),
      BRAM_Din_A(3) => dlmb_port_DOUT(28),
      BRAM_Din_A(4) => dlmb_port_DOUT(27),
      BRAM_Din_A(5) => dlmb_port_DOUT(26),
      BRAM_Din_A(6) => dlmb_port_DOUT(25),
      BRAM_Din_A(7) => dlmb_port_DOUT(24),
      BRAM_Din_A(8) => dlmb_port_DOUT(23),
      BRAM_Din_A(9) => dlmb_port_DOUT(22),
      BRAM_Din_A(10) => dlmb_port_DOUT(21),
      BRAM_Din_A(11) => dlmb_port_DOUT(20),
      BRAM_Din_A(12) => dlmb_port_DOUT(19),
      BRAM_Din_A(13) => dlmb_port_DOUT(18),
      BRAM_Din_A(14) => dlmb_port_DOUT(17),
      BRAM_Din_A(15) => dlmb_port_DOUT(16),
      BRAM_Din_A(16) => dlmb_port_DOUT(15),
      BRAM_Din_A(17) => dlmb_port_DOUT(14),
      BRAM_Din_A(18) => dlmb_port_DOUT(13),
      BRAM_Din_A(19) => dlmb_port_DOUT(12),
      BRAM_Din_A(20) => dlmb_port_DOUT(11),
      BRAM_Din_A(21) => dlmb_port_DOUT(10),
      BRAM_Din_A(22) => dlmb_port_DOUT(9),
      BRAM_Din_A(23) => dlmb_port_DOUT(8),
      BRAM_Din_A(24) => dlmb_port_DOUT(7),
      BRAM_Din_A(25) => dlmb_port_DOUT(6),
      BRAM_Din_A(26) => dlmb_port_DOUT(5),
      BRAM_Din_A(27) => dlmb_port_DOUT(4),
      BRAM_Din_A(28) => dlmb_port_DOUT(3),
      BRAM_Din_A(29) => dlmb_port_DOUT(2),
      BRAM_Din_A(30) => dlmb_port_DOUT(1),
      BRAM_Din_A(31) => dlmb_port_DOUT(0),
      BRAM_Dout_A(0 to 31) => dlmb_port_DIN(0 to 31),
      BRAM_EN_A => dlmb_port_EN,
      BRAM_Rst_A => dlmb_port_RST,
      BRAM_WEN_A(0 to 3) => dlmb_port_WE(0 to 3),
      LMB_ABus(0 to 31) => dlmb_sl_0_ABUS(0 to 31),
      LMB_AddrStrobe => dlmb_sl_0_ADDRSTROBE,
      LMB_BE(0 to 3) => dlmb_sl_0_BE(0 to 3),
      LMB_Clk => Clk1,
      LMB_ReadStrobe => dlmb_sl_0_READSTROBE,
      LMB_Rst => LMB_Rst1(0),
      LMB_WriteDBus(0 to 31) => dlmb_sl_0_WRITEDBUS(0 to 31),
      LMB_WriteStrobe => dlmb_sl_0_WRITESTROBE,
      Sl_CE => dlmb_sl_0_CE,
      Sl_DBus(0 to 31) => dlmb_sl_0_READDBUS(0 to 31),
      Sl_Ready => dlmb_sl_0_READY,
      Sl_UE => dlmb_sl_0_UE,
      Sl_Wait => dlmb_sl_0_WAIT
    );
ilmb: component bd_3914_ilmb_0
     port map (
      LMB_ABus(0 to 31) => ilmb_sl_0_ABUS(0 to 31),
      LMB_AddrStrobe => ilmb_sl_0_ADDRSTROBE,
      LMB_BE(0 to 3) => ilmb_sl_0_BE(0 to 3),
      LMB_CE => ilmb_CE,
      LMB_Clk => Clk1,
      LMB_ReadDBus(0 to 31) => ilmb_READDBUS(0 to 31),
      LMB_ReadStrobe => ilmb_sl_0_READSTROBE,
      LMB_Ready => ilmb_READY,
      LMB_Rst => NLW_ilmb_LMB_Rst_UNCONNECTED,
      LMB_UE => ilmb_UE,
      LMB_Wait => ilmb_WAIT,
      LMB_WriteDBus(0 to 31) => ilmb_sl_0_WRITEDBUS(0 to 31),
      LMB_WriteStrobe => ilmb_sl_0_WRITESTROBE,
      M_ABus(0 to 31) => ilmb_ABUS(0 to 31),
      M_AddrStrobe => ilmb_ADDRSTROBE,
      M_BE(0 to 3) => B"0000",
      M_DBus(0 to 31) => B"00000000000000000000000000000000",
      M_ReadStrobe => ilmb_READSTROBE,
      M_WriteStrobe => '0',
      SYS_Rst => LMB_Rst1(0),
      Sl_CE(0) => ilmb_sl_0_CE,
      Sl_DBus(0 to 31) => ilmb_sl_0_READDBUS(0 to 31),
      Sl_Ready(0) => ilmb_sl_0_READY,
      Sl_UE(0) => ilmb_sl_0_UE,
      Sl_Wait(0) => ilmb_sl_0_WAIT
    );
ilmb_cntlr: component bd_3914_ilmb_cntlr_0
     port map (
      BRAM_Addr_A(0 to 31) => ilmb_port_ADDR(0 to 31),
      BRAM_Clk_A => ilmb_port_CLK,
      BRAM_Din_A(0) => ilmb_port_DOUT(31),
      BRAM_Din_A(1) => ilmb_port_DOUT(30),
      BRAM_Din_A(2) => ilmb_port_DOUT(29),
      BRAM_Din_A(3) => ilmb_port_DOUT(28),
      BRAM_Din_A(4) => ilmb_port_DOUT(27),
      BRAM_Din_A(5) => ilmb_port_DOUT(26),
      BRAM_Din_A(6) => ilmb_port_DOUT(25),
      BRAM_Din_A(7) => ilmb_port_DOUT(24),
      BRAM_Din_A(8) => ilmb_port_DOUT(23),
      BRAM_Din_A(9) => ilmb_port_DOUT(22),
      BRAM_Din_A(10) => ilmb_port_DOUT(21),
      BRAM_Din_A(11) => ilmb_port_DOUT(20),
      BRAM_Din_A(12) => ilmb_port_DOUT(19),
      BRAM_Din_A(13) => ilmb_port_DOUT(18),
      BRAM_Din_A(14) => ilmb_port_DOUT(17),
      BRAM_Din_A(15) => ilmb_port_DOUT(16),
      BRAM_Din_A(16) => ilmb_port_DOUT(15),
      BRAM_Din_A(17) => ilmb_port_DOUT(14),
      BRAM_Din_A(18) => ilmb_port_DOUT(13),
      BRAM_Din_A(19) => ilmb_port_DOUT(12),
      BRAM_Din_A(20) => ilmb_port_DOUT(11),
      BRAM_Din_A(21) => ilmb_port_DOUT(10),
      BRAM_Din_A(22) => ilmb_port_DOUT(9),
      BRAM_Din_A(23) => ilmb_port_DOUT(8),
      BRAM_Din_A(24) => ilmb_port_DOUT(7),
      BRAM_Din_A(25) => ilmb_port_DOUT(6),
      BRAM_Din_A(26) => ilmb_port_DOUT(5),
      BRAM_Din_A(27) => ilmb_port_DOUT(4),
      BRAM_Din_A(28) => ilmb_port_DOUT(3),
      BRAM_Din_A(29) => ilmb_port_DOUT(2),
      BRAM_Din_A(30) => ilmb_port_DOUT(1),
      BRAM_Din_A(31) => ilmb_port_DOUT(0),
      BRAM_Dout_A(0 to 31) => ilmb_port_DIN(0 to 31),
      BRAM_EN_A => ilmb_port_EN,
      BRAM_Rst_A => ilmb_port_RST,
      BRAM_WEN_A(0 to 3) => ilmb_port_WE(0 to 3),
      LMB_ABus(0 to 31) => ilmb_sl_0_ABUS(0 to 31),
      LMB_AddrStrobe => ilmb_sl_0_ADDRSTROBE,
      LMB_BE(0 to 3) => ilmb_sl_0_BE(0 to 3),
      LMB_Clk => Clk1,
      LMB_ReadStrobe => ilmb_sl_0_READSTROBE,
      LMB_Rst => LMB_Rst1(0),
      LMB_WriteDBus(0 to 31) => ilmb_sl_0_WRITEDBUS(0 to 31),
      LMB_WriteStrobe => ilmb_sl_0_WRITESTROBE,
      Sl_CE => ilmb_sl_0_CE,
      Sl_DBus(0 to 31) => ilmb_sl_0_READDBUS(0 to 31),
      Sl_Ready => ilmb_sl_0_READY,
      Sl_UE => ilmb_sl_0_UE,
      Sl_Wait => ilmb_sl_0_WAIT
    );
iomodule_0: component bd_3914_iomodule_0_0
     port map (
      Clk => Clk1,
      IO_Addr_Strobe => iomodule_0_IO_ADDR_STROBE,
      IO_Address(31 downto 0) => iomodule_0_IO_ADDRESS(31 downto 0),
      IO_Byte_Enable(3 downto 0) => iomodule_0_IO_BYTE_ENABLE(3 downto 0),
      IO_Read_Data(31 downto 0) => iomodule_0_IO_READ_DATA(31 downto 0),
      IO_Read_Strobe => iomodule_0_IO_READ_STROBE,
      IO_Ready => iomodule_0_IO_READY,
      IO_Write_Data(31 downto 0) => iomodule_0_IO_WRITE_DATA(31 downto 0),
      IO_Write_Strobe => iomodule_0_IO_WRITE_STROBE,
      LMB_ABus(0 to 31) => dlmb_sl_0_ABUS(0 to 31),
      LMB_AddrStrobe => dlmb_sl_0_ADDRSTROBE,
      LMB_BE(0 to 3) => dlmb_sl_0_BE(0 to 3),
      LMB_ReadStrobe => dlmb_sl_0_READSTROBE,
      LMB_WriteDBus(0 to 31) => dlmb_sl_0_WRITEDBUS(0 to 31),
      LMB_WriteStrobe => dlmb_sl_0_WRITESTROBE,
      Rst => IO_Rst(0),
      Sl_CE => dlmb_sl_1_CE,
      Sl_DBus(0 to 31) => dlmb_sl_1_READDBUS(0 to 31),
      Sl_Ready => dlmb_sl_1_READY,
      Sl_UE => dlmb_sl_1_UE,
      Sl_Wait => dlmb_sl_1_WAIT
    );
lmb_bram_I: component bd_3914_lmb_bram_I_0
     port map (
      addra(31) => dlmb_port_ADDR(0),
      addra(30) => dlmb_port_ADDR(1),
      addra(29) => dlmb_port_ADDR(2),
      addra(28) => dlmb_port_ADDR(3),
      addra(27) => dlmb_port_ADDR(4),
      addra(26) => dlmb_port_ADDR(5),
      addra(25) => dlmb_port_ADDR(6),
      addra(24) => dlmb_port_ADDR(7),
      addra(23) => dlmb_port_ADDR(8),
      addra(22) => dlmb_port_ADDR(9),
      addra(21) => dlmb_port_ADDR(10),
      addra(20) => dlmb_port_ADDR(11),
      addra(19) => dlmb_port_ADDR(12),
      addra(18) => dlmb_port_ADDR(13),
      addra(17) => dlmb_port_ADDR(14),
      addra(16) => dlmb_port_ADDR(15),
      addra(15) => dlmb_port_ADDR(16),
      addra(14) => dlmb_port_ADDR(17),
      addra(13) => dlmb_port_ADDR(18),
      addra(12) => dlmb_port_ADDR(19),
      addra(11) => dlmb_port_ADDR(20),
      addra(10) => dlmb_port_ADDR(21),
      addra(9) => dlmb_port_ADDR(22),
      addra(8) => dlmb_port_ADDR(23),
      addra(7) => dlmb_port_ADDR(24),
      addra(6) => dlmb_port_ADDR(25),
      addra(5) => dlmb_port_ADDR(26),
      addra(4) => dlmb_port_ADDR(27),
      addra(3) => dlmb_port_ADDR(28),
      addra(2) => dlmb_port_ADDR(29),
      addra(1) => dlmb_port_ADDR(30),
      addra(0) => dlmb_port_ADDR(31),
      addrb(31) => ilmb_port_ADDR(0),
      addrb(30) => ilmb_port_ADDR(1),
      addrb(29) => ilmb_port_ADDR(2),
      addrb(28) => ilmb_port_ADDR(3),
      addrb(27) => ilmb_port_ADDR(4),
      addrb(26) => ilmb_port_ADDR(5),
      addrb(25) => ilmb_port_ADDR(6),
      addrb(24) => ilmb_port_ADDR(7),
      addrb(23) => ilmb_port_ADDR(8),
      addrb(22) => ilmb_port_ADDR(9),
      addrb(21) => ilmb_port_ADDR(10),
      addrb(20) => ilmb_port_ADDR(11),
      addrb(19) => ilmb_port_ADDR(12),
      addrb(18) => ilmb_port_ADDR(13),
      addrb(17) => ilmb_port_ADDR(14),
      addrb(16) => ilmb_port_ADDR(15),
      addrb(15) => ilmb_port_ADDR(16),
      addrb(14) => ilmb_port_ADDR(17),
      addrb(13) => ilmb_port_ADDR(18),
      addrb(12) => ilmb_port_ADDR(19),
      addrb(11) => ilmb_port_ADDR(20),
      addrb(10) => ilmb_port_ADDR(21),
      addrb(9) => ilmb_port_ADDR(22),
      addrb(8) => ilmb_port_ADDR(23),
      addrb(7) => ilmb_port_ADDR(24),
      addrb(6) => ilmb_port_ADDR(25),
      addrb(5) => ilmb_port_ADDR(26),
      addrb(4) => ilmb_port_ADDR(27),
      addrb(3) => ilmb_port_ADDR(28),
      addrb(2) => ilmb_port_ADDR(29),
      addrb(1) => ilmb_port_ADDR(30),
      addrb(0) => ilmb_port_ADDR(31),
      clka => dlmb_port_CLK,
      clkb => ilmb_port_CLK,
      dina(31) => dlmb_port_DIN(0),
      dina(30) => dlmb_port_DIN(1),
      dina(29) => dlmb_port_DIN(2),
      dina(28) => dlmb_port_DIN(3),
      dina(27) => dlmb_port_DIN(4),
      dina(26) => dlmb_port_DIN(5),
      dina(25) => dlmb_port_DIN(6),
      dina(24) => dlmb_port_DIN(7),
      dina(23) => dlmb_port_DIN(8),
      dina(22) => dlmb_port_DIN(9),
      dina(21) => dlmb_port_DIN(10),
      dina(20) => dlmb_port_DIN(11),
      dina(19) => dlmb_port_DIN(12),
      dina(18) => dlmb_port_DIN(13),
      dina(17) => dlmb_port_DIN(14),
      dina(16) => dlmb_port_DIN(15),
      dina(15) => dlmb_port_DIN(16),
      dina(14) => dlmb_port_DIN(17),
      dina(13) => dlmb_port_DIN(18),
      dina(12) => dlmb_port_DIN(19),
      dina(11) => dlmb_port_DIN(20),
      dina(10) => dlmb_port_DIN(21),
      dina(9) => dlmb_port_DIN(22),
      dina(8) => dlmb_port_DIN(23),
      dina(7) => dlmb_port_DIN(24),
      dina(6) => dlmb_port_DIN(25),
      dina(5) => dlmb_port_DIN(26),
      dina(4) => dlmb_port_DIN(27),
      dina(3) => dlmb_port_DIN(28),
      dina(2) => dlmb_port_DIN(29),
      dina(1) => dlmb_port_DIN(30),
      dina(0) => dlmb_port_DIN(31),
      dinb(31) => ilmb_port_DIN(0),
      dinb(30) => ilmb_port_DIN(1),
      dinb(29) => ilmb_port_DIN(2),
      dinb(28) => ilmb_port_DIN(3),
      dinb(27) => ilmb_port_DIN(4),
      dinb(26) => ilmb_port_DIN(5),
      dinb(25) => ilmb_port_DIN(6),
      dinb(24) => ilmb_port_DIN(7),
      dinb(23) => ilmb_port_DIN(8),
      dinb(22) => ilmb_port_DIN(9),
      dinb(21) => ilmb_port_DIN(10),
      dinb(20) => ilmb_port_DIN(11),
      dinb(19) => ilmb_port_DIN(12),
      dinb(18) => ilmb_port_DIN(13),
      dinb(17) => ilmb_port_DIN(14),
      dinb(16) => ilmb_port_DIN(15),
      dinb(15) => ilmb_port_DIN(16),
      dinb(14) => ilmb_port_DIN(17),
      dinb(13) => ilmb_port_DIN(18),
      dinb(12) => ilmb_port_DIN(19),
      dinb(11) => ilmb_port_DIN(20),
      dinb(10) => ilmb_port_DIN(21),
      dinb(9) => ilmb_port_DIN(22),
      dinb(8) => ilmb_port_DIN(23),
      dinb(7) => ilmb_port_DIN(24),
      dinb(6) => ilmb_port_DIN(25),
      dinb(5) => ilmb_port_DIN(26),
      dinb(4) => ilmb_port_DIN(27),
      dinb(3) => ilmb_port_DIN(28),
      dinb(2) => ilmb_port_DIN(29),
      dinb(1) => ilmb_port_DIN(30),
      dinb(0) => ilmb_port_DIN(31),
      douta(31 downto 0) => dlmb_port_DOUT(31 downto 0),
      doutb(31 downto 0) => ilmb_port_DOUT(31 downto 0),
      ena => dlmb_port_EN,
      enb => ilmb_port_EN,
      rsta => dlmb_port_RST,
      rsta_busy => NLW_lmb_bram_I_rsta_busy_UNCONNECTED,
      rstb => ilmb_port_RST,
      rstb_busy => NLW_lmb_bram_I_rstb_busy_UNCONNECTED,
      wea(3) => dlmb_port_WE(0),
      wea(2) => dlmb_port_WE(1),
      wea(1) => dlmb_port_WE(2),
      wea(0) => dlmb_port_WE(3),
      web(3) => ilmb_port_WE(0),
      web(2) => ilmb_port_WE(1),
      web(1) => ilmb_port_WE(2),
      web(0) => ilmb_port_WE(3)
    );
mdm_0: component bd_3914_mdm_0_0
     port map (
      Dbg_Capture_0 => microblaze_I_mdm_bus_CAPTURE,
      Dbg_Clk_0 => microblaze_I_mdm_bus_CLK,
      Dbg_Disable_0 => microblaze_I_mdm_bus_DISABLE,
      Dbg_Reg_En_0(0 to 7) => microblaze_I_mdm_bus_REG_EN(0 to 7),
      Dbg_Rst_0 => microblaze_I_mdm_bus_RST,
      Dbg_Shift_0 => microblaze_I_mdm_bus_SHIFT,
      Dbg_TDI_0 => microblaze_I_mdm_bus_TDI,
      Dbg_TDO_0 => microblaze_I_mdm_bus_TDO,
      Dbg_Update_0 => microblaze_I_mdm_bus_UPDATE,
      Debug_SYS_Rst => Debug_SYS_Rst
    );
microblaze_I: component bd_3914_microblaze_I_0
     port map (
      Byte_Enable(0 to 3) => dlmb_BE(0 to 3),
      Clk => Clk1,
      DCE => dlmb_CE,
      DReady => dlmb_READY,
      DUE => dlmb_UE,
      DWait => dlmb_WAIT,
      D_AS => dlmb_ADDRSTROBE,
      Data_Addr(0 to 31) => dlmb_ABUS(0 to 31),
      Data_Read(0 to 31) => dlmb_READDBUS(0 to 31),
      Data_Write(0 to 31) => dlmb_WRITEDBUS(0 to 31),
      Dbg_Capture => microblaze_I_mdm_bus_CAPTURE,
      Dbg_Clk => microblaze_I_mdm_bus_CLK,
      Dbg_Continue => NLW_microblaze_I_Dbg_Continue_UNCONNECTED,
      Dbg_Disable => microblaze_I_mdm_bus_DISABLE,
      Dbg_Reg_En(0 to 7) => microblaze_I_mdm_bus_REG_EN(0 to 7),
      Dbg_Shift => microblaze_I_mdm_bus_SHIFT,
      Dbg_Stop => '0',
      Dbg_TDI => microblaze_I_mdm_bus_TDI,
      Dbg_TDO => microblaze_I_mdm_bus_TDO,
      Dbg_Update => microblaze_I_mdm_bus_UPDATE,
      Dbg_Wakeup => Dbg_Wakeup,
      Debug_Rst => microblaze_I_mdm_bus_RST,
      Ext_BRK => '0',
      Ext_NM_BRK => '0',
      Hibernate => NLW_microblaze_I_Hibernate_UNCONNECTED,
      ICE => ilmb_CE,
      IFetch => ilmb_READSTROBE,
      IReady => ilmb_READY,
      IUE => ilmb_UE,
      IWAIT => ilmb_WAIT,
      I_AS => ilmb_ADDRSTROBE,
      Instr(0 to 31) => ilmb_READDBUS(0 to 31),
      Instr_Addr(0 to 31) => ilmb_ABUS(0 to 31),
      Interrupt => '0',
      Interrupt_Ack(0 to 1) => NLW_microblaze_I_Interrupt_Ack_UNCONNECTED(0 to 1),
      Interrupt_Address(0 to 31) => B"00000000000000000000000000000000",
      MB_Halted => NLW_microblaze_I_MB_Halted_UNCONNECTED,
      Non_Secure(0 to 3) => B"0000",
      Pause => '0',
      Pause_Ack => NLW_microblaze_I_Pause_Ack_UNCONNECTED,
      Read_Strobe => dlmb_READSTROBE,
      Reset => MB_Reset,
      Reset_Mode(0 to 1) => B"00",
      Sleep => NLW_microblaze_I_Sleep_UNCONNECTED,
      Suspend => NLW_microblaze_I_Suspend_UNCONNECTED,
      Wakeup(0) => Wakeup(1),
      Wakeup(1) => Wakeup(0),
      Write_Strobe => dlmb_WRITESTROBE
    );
rst_0: component bd_3914_rst_0_0
     port map (
      aux_reset_in => '1',
      bus_struct_reset(0) => LMB_Rst1(0),
      dcm_locked => '1',
      ext_reset_in => Reset,
      interconnect_aresetn(0) => NLW_rst_0_interconnect_aresetn_UNCONNECTED(0),
      mb_debug_sys_rst => Debug_SYS_Rst,
      mb_reset => MB_Reset,
      peripheral_aresetn(0) => NLW_rst_0_peripheral_aresetn_UNCONNECTED(0),
      peripheral_reset(0) => IO_Rst(0),
      slowest_sync_clk => Clk1
    );
xlconcat_0: component bd_3914_xlconcat_0_0
     port map (
      In0(0) => Dbg_Wakeup,
      In1(0) => Dbg_Wakeup,
      dout(1 downto 0) => Wakeup(1 downto 0)
    );
end STRUCTURE;
