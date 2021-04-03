/*****************************************************************//**
 * @file lfsr_core.h
 *
 * @brief Init and retrieve the random number from the lfsr_core
 *
 * @author Ali Alsayed
 * @version v1.0: initial release
 ********************************************************************/

#ifndef _LFSR_H_INCLUDED
#define _LFSR_H_INCLUDED

#include "chu_io_rw.h"

/**
 * timer core driver:
 *  - control and retrieve clock count from MMIO timer core.
 *
 */
class LfsrCore {
public:
   /**
    * register map
    *
    */
   enum {
      READ_REG = 0, /**< lower 32 bits of counter */
      CTRL_REG = 1  /**< control register */
   };
   /**
   * field masks
   *
   */
   enum {
      INIT_FIELD = 0x00000001 /**< bit 0 of ctrl_reg; INIT bit  */
   };
   /* methods */
   /**
    * constructor.
    *
    */
   LfsrCore(uint32_t core_base_addr);
   ~LfsrCore();                  // not used

   /**
    * initialize the lfsr
    *
    */
   void init();


   /**
    * read current random value from the lfsr
    *
    */
   uint32_t read_rand();

   

private:
   uint32_t base_addr;
   uint32_t ctrl;    // current state of control register
};

#endif  // _LFSR_H_INCLUDED
