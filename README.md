# ULP blink

Me trying to make an esp32 blink via ULP.

Since there is no PlatformIO integration for ULP, I'll use plain ESP-IDF.
But I reuse the PlatformIO framework for espidf. No need for two copies.

## Installation (using Linux with Python 2.x)

* Install PlatformIO IDE with shell commands or just the core
```
pip install platformio
```
see https://platformio.org/install for details

* Install PlatformIO framework espidf for platform espressif32
```
pio platforms install espressif32 --with-package framework-espidf
```

* Install ULP toolchain
```
mkdir -p ~/esp32
cd ~/esp32
wget https://github.com/espressif/binutils-esp32ulp/releases/download/v2.28.51-esp32ulp-20180809/binutils-esp32ulp-linux64-2.28.51-esp32ulp-20180809.tar.gz
tar xzf binutils-esp32ulp-linux64-2.28.51-esp32ulp-20180809.tar.gz
```
Check for updates at https://github.com/espressif/binutils-esp32ulp/releases/latest)

* Configure environment for the ESP-IDF
```
echo 'export IDF_PATH=$HOME/.platformio/packages/framework-espidf' >~/esp32/env.sh
echo 'export PATH=$IDF_PATH/bin:$IDF_PATH/../toolchain-xtensa32/bin:$PATH' >>~/esp32/env.sh
echo 'export PATH=~/esp32/esp32ulp-elf-binutils/bin:$PATH' >>~/esp32/env.sh
```
Best to add this to your ~/.profile
```
. ~/esp32/env.sh
```

## Build - Flash - Monitor
* Prepare shell to use ESP-IDF (if not done by your .profile already)
```
. ~/esp32/env.sh
```

* Fetch and build this example, flash it and open serial console (adapt ESPPORT and ESPBAUD to your setup. Can be configured in sdkconfig file)
```
mkdir /tmp/blink-$$ && \
cd /tmp/blink-$$ && \
git clone https://github.com/joba-1/Blink-ULP.git && \
cd Blink-ULP && \
make -j8 flash monitor ESPPORT=/dev/ttyUSB0 ESPBAUD=115200

```
A led connected to gnd (kathode) and gpio2 (anode) should blink now.

Exit the monitor with [Ctrl]-] (which is [Strg]-[Alt-Gr]-] on german keyboard)

## Other make targets

### Just build the app 
I use this for auto build in eclipse
```
make app
```

### Build the app and flash it, but not config or bootloader
A bit faster and usually enough after the first flash
```
make app-flash
```

### List all the other possibilities
```
make help
```

## ToDo

Currently I have to do a rtc_gpio_init() in the main processor.
If I dont, the pin wont toggle and stays off.
I think it should be possible to do the equivalent init in ULP, but so far something is missing...


JoBa1
