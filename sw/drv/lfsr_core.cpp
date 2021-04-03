/*****************************************************************//**
 * @file tlfsr_core.cpp
 *
 * @brief implementation of LfsrCore class
 *
 * @author Ali Alsayed
 * @version v1.0: initial release
 ********************************************************************/

#include "lfsr_core.h"

LfsrCore::LfsrCore(uint32_t core_base_addr) {
   base_addr = core_base_addr;
   ctrl = 0x01; //initialize
   io_write(base_addr, CTRL_REG, ctrl);  // enable the timer
}

LfsrCore::~LfsrCore() {
}

void LfsrCore::init() {
   // reset enable bit to 0
   ctrl = ctrl & ~INIT_FIELD;
   io_write(base_addr, CTRL_REG, ctrl);
}


uint32_t LfsrCore::read_rand() {
   // elapsed time in microsecond (SYS_CLK_FREQ in MHz)
   return io_read(base_addr,0);
}

