#!/bin/sh

# By default U-Boot loads DTB from a file named "zynq-red_pitaya.dtb", so
# let's use a symlink with that name that points to the current
# devicetree in the config.

CURRENT_DT=$(sed -n 's/^BR2_LINUX_KERNEL_INTREE_DTS_NAME="\(.*\)"$/\1/p' \
	${BR2_CONFIG})

[ -z "${CURRENT_DT}" ] || ln -fs ${CURRENT_DT}.dtb ${BINARIES_DIR}/zynq-red_pitaya.dtb

support/scripts/genimage.sh -c "${3}"
