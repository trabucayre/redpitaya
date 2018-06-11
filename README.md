# redpitaya

This repository provides buildroot based support for redpitaya board.

It uses the BR2_EXTERNAL mecanism to add this support in buildroot.

This support has been tested with the latest long term support release of buildroot (2018.02.2).

How-to use it
=============

You need to download corresponding tarball:

	wget https://buildroot.org/downloads/buildroot-2018.02.2.tar.gz

To add the support you need to source **sourceme.ggm** file to add **BR2_EXTERNAL** to
your env (it's possible to add <code>export
BR2_EXTERNAL=/somewhere/redpitaya</code> in *.bashrc*).

Now, in buildroot directory you can use 
	make redpitaya_defconfig
or
	make redpitaya_xenomai_defconfig
to configure buildroot

Note
====

**red_vivado_support** directory contains basic files to add redpitaya support
to vivado to select this board when creating a new project.
