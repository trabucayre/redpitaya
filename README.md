# redpitaya

This repository provides buildroot based support for redpitaya (12, 14, and 16 bits) board.

It uses the BR2_EXTERNAL mecanism to add this support in buildroot.

This support has been tested with the latest stable release of buildroot (2025.08).

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

ethernet MAC address is generates ramdomly (in fact it's always the same). If
you have more than one *redpitaya* and you want to use an DHCP server to set the IP,
the next line
```
ethaddr=xx:xx:xx:xx
```
has to be added in the **uEnv.txt** file, located in the first SD-card partition.

**Note: a sticker with the Official MAC address is glued in the *redpitaya*
ethernet connector.**

Note
====

**red_vivado_support** directory contains basic files to add redpitaya support
to vivado to select this board when creating a new project.
