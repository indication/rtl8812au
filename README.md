## Realtek 802.11ac (rtl8812au)

This is a fork of the Realtek 802.11ac (rtl8812au) v4.2.5 (10640.20140303)
driver altered to build on Linux kernel version >= 3.10.
-> driver altered to build on Raspberry Pi with above Linux kernel (disabled power savings!, not working)

### Purpose

My Sitecom WLA-7100 wireless dual-band USB adapter needs the Realtek 8812au
driver to work under Linux.

The current rtl8812au version (per nov. 20th 2013) doesn't compile on Linux
kernels >= 3.10 due to a change in the proc entry API, specifically the
deprecation of the `create_proc_entry()` and `create_proc_read_entry()`
functions in favor of the new `proc_create()` function. 

Disabling process-proc is also an option.

### Building (you may customize this to your settings)
```sh
$ cd /home/pi
$ wget --no-check-certificate https://codeload.github.com/raspberrypi/linux/tar.gz/rpi-3.10.y
$ tar -xzf rpi-3.10.y.tar.gz
$ rm rpi-3.10.y.tar.gz
$ cd linux-rpi-3.10.y
$ make mrproper
$ zcat /proc/config.gz > .config
$ cp .config .config.org
$ sed -i 's/^CONFIG_CROSS_COMPILE.*/CONFIG_CROSS_COMPILE=""/' .config
$ make modules_prepare
$ cp /lib/modules/$(uname -r)/build/Module.symvers .
$ cd /home/pi
$ git clone https://github.com/sblommers/rpi-linux-rtl8812au
$ cd rpi-linux-rtl8812au
$ make
$ sudo insmod 8812au.ko
$ sudo cp 8812au.ko /lib/modules/$(uname -r)/kernel/drivers/net/wireless
$ sudo depmod
```

### Installing

Installing the driver is simply a matter of copying the built module
into the correct location and updating module dependencies using `depmod`:

```sh
$ sudo cp 8812au.ko /lib/modules/$(uname -r)/kernel/drivers/net/wireless
$ sudo depmod
```

The driver module should now be loaded automatically.

### References

- Sitecom 
  - [Product page](http://www.sitecom.com/en/wi-fi-usb-30-adapter-ac1200/wla-7100/p/1617)
  - [wikidevi page](http://wikidevi.com/wiki/Sitecom_WLA-7100)
