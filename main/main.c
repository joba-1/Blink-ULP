/*
 * JoBa1 ESP32 ULP blink example
 *
 * Load and start an ULP programm, then go to sleep
 */

#include <stdio.h>         // printf(), fflush()
#include "ulp-util.h"      // ulp_init(), ulp_start()
#include "driver/rtc_io.h" // rtc_gpio_init()
#include "esp_sleep.h"     // esp_sleep_enable_ulp_wakeup(), esp_deep_sleep_start()

void app_main()
{
  printf("Hello Blink ULP!\n");

  // Would like to do this in ULP but failed so far...
  rtc_gpio_init(GPIO_NUM_2); 

  ulp_init();
  ulp_start();

  printf("Started ULP, going to sleep now.\n");
  fflush(stdout);

  ESP_ERROR_CHECK( esp_sleep_enable_ulp_wakeup() );
  esp_deep_sleep_start();
}
