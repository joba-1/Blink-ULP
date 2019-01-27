/*
 * JoBa1 ESP32 ULP blink example
 *
 * Simple ULP program that initializes a gpio pin and toggles it high/low
 */

#include "soc/soc_ulp.h"     // for WRITE_RTC_REG
#include "soc/rtc_io_reg.h"  // for RTC_GPIO_*


.global entry                // ulp start address used by main core program

.set gpio_2, 12              // gpio pin 2 is rtc pin 12

.text

entry:
  // This tries to mimic rtc_gpio_init(GPIO_NUM_2), but does not work yet :(
  // WRITE_RTC_REG(RTC_IO_TOUCH_PAD2_REG, RTC_IO_TOUCH_PAD2_MUX_SEL_M, 1, 1)
  // WRITE_RTC_REG(RTC_IO_TOUCH_PAD2_REG, RTC_IO_TOUCH_PAD2_FUN_SEL_M, 1, 0)
  
  WRITE_RTC_REG(RTC_GPIO_OUT_REG, RTC_GPIO_OUT_DATA_S + gpio_2, 1, 1)

next:

  WRITE_RTC_REG(RTC_GPIO_ENABLE_W1TS_REG, RTC_GPIO_ENABLE_W1TS_S + gpio_2, 1, 1)

  move  r1,200            // wait in ms
delay0:
  wait  8000              // wait 8000 clock ticks at 8MHz -> 1ms
  sub   r1, r1, 1         // decrement ms count
  jump  delay0_ready, eq  // if ms count is zero then return to caller
  jump  delay0            // else continue to wait
delay0_ready:

  WRITE_RTC_REG(RTC_GPIO_ENABLE_W1TC_REG, RTC_GPIO_ENABLE_W1TC_S + gpio_2, 1, 1)

  move  r1,800            // wait in ms
delay1:
  wait  8000              // wait 8000 clock ticks at 8MHz -> 1ms
  sub   r1, r1, 1         // decrement ms count
  jump  delay1_ready, eq  // if ms count is zero then return to caller
  jump  delay1            // else continue to wait
delay1_ready:

  jump  next

