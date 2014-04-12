cd /home/pi
wget --no-check-certificate https://codeload.github.com/raspberrypi/linux/tar.gz/rpi-3.10.y
tar -xzf rpi-3.10.y.tar.gz
rm rpi-3.10.y.tar.gz
cd linux-rpi-3.10.y
make mrproper
zcat /proc/config.gz > .config
cp .config .config.org
sed -i 's/^CONFIG_CROSS_COMPILE.*/CONFIG_CROSS_COMPILE=""/' .config
make modules_prepare
cp /lib/modules/$(uname -r)/build/Module.symvers .
cd /home/pi
git clone https://github.com/sblommers/rpi-linux-rtl8812au
cd rpi-linux-rtl8812au
make
sudo insmod 8812au.ko
sudo cp 8812au.ko /lib/modules/$(uname -r)/kernel/drivers/net/wireless
sudo depmod
