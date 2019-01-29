/*
 * JoBa1 ESP32 ULP blink example
 *
 * Load and start an ULP programm, then go to sleep
 */

#include <stdio.h>         // printf(), fflush()
#include "esp_sleep.h"     // esp_sleep_enable_ulp_wakeup(), esp_deep_sleep_start()

#include "ulp-util.h"      // my ulp_init(), ulp_start()

void app_main()
{
  printf("Hello Blink ULP!\n");

  ulp_init();
  ulp_start();

  printf("Started ULP, going to sleep now.\n");
  fflush(stdout);

  ESP_ERROR_CHECK( esp_sleep_enable_ulp_wakeup() );
  esp_deep_sleep_start();
}
