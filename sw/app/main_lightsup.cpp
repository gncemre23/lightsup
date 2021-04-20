/*****************************************************************/ /**
 * @file main_lightssup.cpp
 *
 * @brief Implementation of lightsup 3x3 puzzle
 *
 * @author Ali Alsayed
 * @version v1.0: initial release
 *********************************************************************/

// #define _DEBUG
#include "../drv/chu_init.h"
#include "../drv/gpio_cores.h"
#include "../drv/xadc_core.h"
#include "../drv/sseg_core.h"
#include "../drv/spi_core.h"
#include "../drv/i2c_core.h"
#include "../drv/ps2_core.h"
#include "../drv/ddfs_core.h"
#include "../drv/adsr_core.h"
#include "../drv/lfsr_core.h"

// Parameters for state variable
#define WAIT_FOR_START 0
#define GAME 1
#define DISPLAY_WINNING_PATTERN 2

//Parameters for winning patterns
#define ONE 0
#define TWO_FOUR 1
#define THREE_FIVE_SEVEN 2
#define SIX_EIGHT 3
#define NINE 4

//Parameters for buttons
/* btn(0): btnu;  btn(1): btnr;  
   btn(2): btnd; btn(3): btnl;  btn(4): btnc;*/

#define BTNU 1
#define BTND 4
#define BTNC 16




void update_sev_seg(SsegCore *sseg, uint8_t *lights)
{
    uint8_t led1_pattern = 0xff;
    uint8_t led2_pattern = 0xff;
    uint8_t led3_pattern = 0xff;


    led1_pattern &= ~(lights[0] + (lights[1] << 6) + (lights[2] << 3));
    led2_pattern &= ~(lights[3] + (lights[4] << 6) + (lights[5] << 3));
    led3_pattern &= ~(lights[6] + (lights[7] << 6) + (lights[8] << 3));

    sseg->write_1ptn(led1_pattern,3);
    sseg->write_1ptn(led2_pattern, 2);
    sseg->write_1ptn(led3_pattern, 1);
}

/* If all the lights are off return 1 */
uint32_t is_all_lights_off(uint8_t *lights, int size)
{
    for (int i = 0; i < size; i++)
    {
        if (lights[i] == 1)
            return 0;
    }
    return 1;
}

void toggle(uint8_t *light)
{
    if (*light == 1)
        *light = 0;
    else
        *light = 1;
}

uint32_t switch_movement(uint32_t prev, uint32_t current)
{
    uint32_t ret;
    if ((prev - current) == 2)
        ret = 1;
    else if ((prev - current) == 4)
        ret = 2;
    else if ((prev - current) == 8)
        ret = 3;
    else if ((prev - current) == 16)
        ret = 4;
    else if ((prev - current) == 32)
        ret = 5;
    else if ((prev - current) == 64)
        ret = 6;
    else if ((prev - current) == 128)
        ret = 7;
    else if ((prev - current) == 256)
        ret = 8;
    else if ((prev - current) == 512)
        ret = 9;
    else
        ret = 0;
    return ret;
}
void turn_off_all_ligths(uint8_t *lights, int size)
{
    for (int i = 0; i < size; i++)
    {
        lights[i] = 0;
    }
}

/*Initializing the light array with current random number 
obtained from LFSR*/
void get_rand(uint8_t *lights, LfsrCore *lfsr, int size)
{
    uint32_t mask;
    uint32_t masked_lfsr_out;
    uint32_t lfsr_out = lfsr->read_rand();
    for (int i = 0; i < size; i++)
    {
        mask = 1 << i;
        masked_lfsr_out = lfsr_out & mask;
        lights[i] = masked_lfsr_out >> i;
    }
}

uint32_t get_button_status(DebounceCore *btn)
{
    return btn->read_db();
}

uint32_t get_switch_status(GpiCore *sw)
{
    return sw->read();
}

int main()
{
    uint32_t state = WAIT_FOR_START;
    uint32_t pattern = ONE;
    uint8_t lights[9] = {0};
    unsigned long time_rec;
    uint32_t switch_current, switch_prev;
    init_fix();

    GpiCore sw(get_slot_addr(BRIDGE_BASE, S3_SW));
    DebounceCore btn(get_slot_addr(BRIDGE_BASE, S7_BTN));
    SsegCore sseg(get_slot_addr(BRIDGE_BASE, S8_SSEG));
    LfsrCore lfsr(get_slot_addr(BRIDGE_BASE, S4_USER));

    while (1)
    {
    	/* For test purposes */
//    	if(state == WAIT_FOR_START)
//    	{
//    		for(int i=0;i<9;i++)
//    			lights[i] = 0;
//    		lights[1]=1;
//    		lights[3]=1;
//    	}
//    	else if(state == GAME)
//    	{
//    		for(int i=0;i<9;i++)
//    			lights[i] = 0;
//    		lights[0]=1;
//    		lights[2]=1;
//    	}
//    	else if(state == DISPLAY_WINNING_PATTERN)
//    	{
//    		for(int i=0;i<9;i++)
//    			lights[i] = 0;
//    		lights[5]=1;
//    		lights[7]=1;
//    	}


        update_sev_seg(&sseg,lights);

        switch (state)
        {
        case WAIT_FOR_START:
            turn_off_all_ligths(lights, 9); //turn off all the lights
            if (get_button_status(&btn) == BTNC)
            {
                state = GAME;
                get_rand(lights, &lfsr, 9); //Initialize lights array with random value
            }
            break;
        case GAME:
            switch_prev = switch_current;
            switch_current = get_switch_status(&sw);

            if (switch_movement(switch_prev, switch_current) == 1)
            {
                toggle(&lights[0]); //toggle light1
                toggle(&lights[1]); //toggle light2
                toggle(&lights[3]); //toggle light4
            }
            else if (switch_movement(switch_prev, switch_current) == 2)
            {
                toggle(&lights[0]);
                toggle(&lights[1]);
                toggle(&lights[2]);
                toggle(&lights[4]);
            }

            else if (switch_movement(switch_prev, switch_current) == 3)
            {
                toggle(&lights[1]);
                toggle(&lights[2]);
                toggle(&lights[5]);
            }

            else if (switch_movement(switch_prev, switch_current) == 4)
            {
                toggle(&lights[0]);
                toggle(&lights[3]);
                toggle(&lights[4]);
            }

            else if (switch_movement(switch_prev, switch_current) == 5)
            {
                toggle(&lights[1]);
                toggle(&lights[3]);
                toggle(&lights[4]);
                toggle(&lights[5]);
                toggle(&lights[7]);
            }

            else if (switch_movement(switch_prev, switch_current) == 6)
            {
                toggle(&lights[2]);
                toggle(&lights[4]);
                toggle(&lights[5]);
                toggle(&lights[8]);
            }

            else if (switch_movement(switch_prev, switch_current) == 7)
            {
                toggle(&lights[3]);
                toggle(&lights[6]);
                toggle(&lights[7]);
            }

            else if (switch_movement(switch_prev, switch_current) == 8)
            {
                toggle(&lights[4]);
                toggle(&lights[6]);
                toggle(&lights[7]);
                toggle(&lights[8]);
            }

            else if (switch_movement(switch_prev, switch_current) == 9)
            {
                toggle(&lights[5]);
                toggle(&lights[7]);
                toggle(&lights[8]);
            }

            if (is_all_lights_off(lights, 9) == 1 || get_button_status(&btn) == BTNU)
            {
                state = DISPLAY_WINNING_PATTERN;
                time_rec = now_ms();
            }
            else if (get_button_status(&btn) == BTND)
                state = WAIT_FOR_START;

            break;

        case DISPLAY_WINNING_PATTERN:
            switch (pattern)
            {
            case ONE:
                for (int i = 0; i < 9; i++)
                {
                    lights[i] = 0;
                }
                lights[0] = 1;

                if (now_ms() - time_rec > 500) // if the duration is 500 ms
                {
                    pattern = TWO_FOUR;
                    time_rec = now_ms();
                }
                break;
            case TWO_FOUR:
                for (int i = 0; i < 9; i++)
                {
                    lights[i] = 0;
                }
                lights[1] = 1; // ligth2 ON
                lights[3] = 1; // lighs4 ON

                if (now_ms() - time_rec > 500) // if the duration is 500 ms
                {
                    pattern = THREE_FIVE_SEVEN;
                    time_rec = now_ms();
                }
                break;
            case THREE_FIVE_SEVEN:
                for (int i = 0; i < 9; i++)
                {
                    lights[i] = 0;
                }
                lights[2] = 1;                 // ligth3 ON
                lights[4] = 1;                 // ligth5 ON
                lights[6] = 1;                 // light7 ON
                if (now_ms() - time_rec > 500) // if the duration is 500 ms
                {
                    pattern = SIX_EIGHT;
                    time_rec = now_ms();
                }
                break;
            case SIX_EIGHT:
                for (int i = 0; i < 9; i++)
                {
                    lights[i] = 0;
                }
                lights[5] = 1;                 // ligth6 ON
                lights[7] = 1;                 // ligth8 ON
                if (now_ms() - time_rec > 500) // if the duration is 500 ms
                {
                    pattern = NINE;
                    time_rec = now_ms();
                }
                break;

            case NINE:
                for (int i = 0; i < 9; i++)
                {
                    lights[i] = 0;
                }
                lights[8] = 1;                 // ligth3 ON
                if (now_ms() - time_rec > 500) // if the duration is 500 ms
                {
                    pattern = ONE;
                    time_rec = now_ms();
                }
                break;

            default:
                break;
            }
            if (get_button_status(&btn) == BTNC)
                state = GAME;
            else if (get_button_status(&btn) == BTND)
                state = WAIT_FOR_START;
            break;

        default:
            break;
        }

    } //while
} //main
