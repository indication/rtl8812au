## Realtek 802.11ac (rtl8812au)

This is a fork of the Realtek 802.11ac (rtl8812au) v4.2.2 (7502.20130507)
driver altered to build on Linux kernel version >= 3.10.

### Purpose

My D-Link DWA-171 wireless dual-band USB adapter needs the Realtek 8812au
driver to work under Linux.

The current rtl8812au version (per nov. 20th 2013) doesn't compile on Linux
kernels >= 3.10 due to a change in the proc entry API, specifically the
deprecation of the `create_proc_entry()` and `create_proc_read_entry()`
functions in favor of the new `proc_create()` function.

### Building using crosscompiling on arm-bcm2708 prepare using
#First we need to install the needed packages (Ubuntu example)
$ apt-get install gcc-arm-linux-gnueabi make ncurses-dev

#Download compilation tools from the official raspberry pi github
$ cd /usr/src
$ git clone --depth 5 https://github.com/raspberrypi/tools.git

#Download the official kernel from the Raspberry Pi github
$ mkdir /opt/raspberry
$ cd /opt/raspberry
$ git clone -b rpi-3.10.y --depth 5 git://github.com/raspberrypi/linux.git
$ cd /opt/raspberry/linux

The driver is build by running `make`, and can be tested by loading the
built module using `insmod`:

```sh
$ make -j6 ARCH=arm CROSS_COMPILE=/usr/src/tools/arm-bcm2708/arm-bcm2708-linux-gnueabi/bin/arm-bcm2708-linux-gnueabi-
$ sudo insmod 8812au.ko
```

After loading the module, a wireless network interface named __Realtek 802.11n WLAN Adapter__ should be available.

### Installing

Installing the driver is simply a matter of copying the built module
into the correct location and updating module dependencies using `depmod`:

```sh
$ sudo 8812au.ko /lib/modules/$(uname -r)/kernel/drivers/net/wireless
$ sudo depmod
```

The driver module should now be loaded automatically.

### References

- D-Link DWA-171
  - [D-Link page](http://www.dlink.com/no/nb/home-solutions/connect/adapters/dwa-171-wireless-ac-dual-band-usb-adapter)
  - [wikidevi page](http://wikidevi.com/wiki/D-Link_DWA-171_rev_A1)
