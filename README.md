# redpitaya

This repository provides buildroot based support for redpitaya (12, 14, and 16 bits) board.

It uses the BR2_EXTERNAL mecanism to add this support in buildroot.

This support has been tested with the latest stable release of buildroot (2026.08).

How-to use it
-------------
### Download
You need to download corresponding tarball:
```bash
wget https://buildroot.org/downloads/buildroot-2025.08.tar.gz
```

### Configure environment
To add the support you need to source **sourceme.ggm** file to add **BR2_EXTERNAL** to
your env (it's possible to add <code>export
BR2_EXTERNAL=/somewhere/redpitaya</code> in *.bashrc*).

Now, in buildroot directory:

You can use for STEMLab 125-14 Redpitaya
```bash
make redpitaya_defconfig
```
or for SDRLab 122-16 Redpitaya
```bash
make redpitaya16_defconfig
```
or for real time extension of Linux for STEMLab 125-14 Redpitaya
```bash
make redpitaya_xenomai_defconfig
```
or for SIGNALlab 250-12 Redpitaya
```bash
make redpitaya12_defconfig
```
to configure buildroot

### build all
Now, with default, or modified, configuration, next step is to build everything
(cross-compiler, u-boot, linux and filesystem):
```bash
make
```

### flash the SD card
After build finished an **sdcard.img** is generated in *output/images*
directory.

It's time to flash your SD card with this disk image by using:
```bash
sudo dd if=output/images/sdcard.img of=/dev/yourSdCard bs=4M
```
where **/dev/yourSdCard** is usually **/dev/sdb** or **/dev/mmcblk0**

<span style="color:red">**NOTE:
This step will destroy all current content of /dev/xxx. So, big care must be
taken about this. dmesg will help you to verify the name of your SD
card**</span>

Tweaks
------

### IP address
By default, the *redpitaya* IP address is 192.168.0.10, to change this value
*/etc/network/interfaces* must be updated. This file is located in the second
partition of the SD card;

default configuration is:
```
auto eth0
iface eth0 inet static
    address 192.168.0.10
    netmask 255.255.255.0
    network 192.168.0.0
    broadcast 192.168.0.255
    gateway 192.168.0.2

```

For example, if you want to use 192.168.10.x network:
```
auto eth0
iface eth0 inet static
    address 192.168.10.10
    netmask 255.255.255.0
    network 192.168.10.0
    broadcast 192.168.10.255
    gateway 192.168.10.2
```

### MAC address

The ethernet MAC address is stored in the I2C EEPROM. But if the EEPROM's
content is formated with an old u-boot, the read fails and an ethaddr
is generates ramdomly (in fact it's always the same). If
you have more than one *redpitaya* and you want to use an DHCP server to set the IP,
the next line
```
ethaddr=xx:xx:xx:xx
```
has to be added in the **uEnv.txt** file, located in the first SD-card partition.

**Note: a sticker with the Official MAC address is glued in the *redpitaya*
ethernet connector.**

If the MAC address doesn't match this sticker, your board's EEPROM may be
using an older format. See **EEPROM content** below. The quickest and
safest fix remains setting `ethaddr` in **uEnv.txt** as shown above.

### EEPROM content

Each *redpitaya* board has a small I2C EEPROM holding the default U-Boot
environment, read automatically at boot, before `uEnv.txt`. This is why the
`uEnv.txt` override above always wins.

To back up the raw content from Linux before making any change:
```
dd if=/sys/bus/nvmem/devices/0-0050*/nvmem of=redpitaya-eeprom-backup.bin bs=8192 count=1
```

To refresh the EEPROM to the current format, read its existing content into
the running environment, then write it back as is. At the U-Boot prompt:
```
Zynq> eeprom read 0x2000000 0x1800 0x400
Zynq> env import -b 0x2000000 0x400
Zynq> env save
```

#### Setting a variable permanently, without uEnv.txt

Any variable can also be changed permanently instead of through `uEnv.txt`,
for example `ipaddr` or `kernel_image`:
```
Zynq> env set ipaddr 192.168.0.20
Zynq> saveenv
```
This writes straight to the EEPROM.

> Note:
>
> If the same variable is also
> present in `uEnv.txt`, `uEnv.txt` is read after the EEPROM, so its value
> wins and overwrites this one on every boot.

Note
====

**red_vivado_support** directory contains basic files to add redpitaya support
to vivado to select this board when creating a new project.
