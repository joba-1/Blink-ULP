# UDF blink

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

* Build this example, flash it and open serial console (defaults for ESPPORT and ESPBAUD can be configured in sdkconfig file)
```
make -j6 flash ESPPORT=/dev/ttyUSB0 ESPBAUD=115200 monitor
```
A led connected to gnd (kathode) and gpio2 (anode) should blink now.

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
make help
```

JoBa1
