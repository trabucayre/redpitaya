#!/bin/sh

# include the linux device tree name corresponding to the desired
# configuration to the genimage configuration file

DTB="$(sed -n 's/^BR2_LINUX_KERNEL_INTREE_DTS_NAME="xilinx\/\([\/a-z0-9_ \-]*\)"$/\1/p' ${BR2_CONFIG})"
BOARD_PATH="$(dirname $0)"

GENIMAGE_CFG="$(mktemp --suffix genimage.cfg)"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

sed -e "s/%DTBFILE%/${DTB}/" \
    ${BOARD_PATH}/genimage-template.cfg \
    > ${GENIMAGE_CFG}

rm -rf "${GENIMAGE_TMP}"

genimage \
    --rootpath "${TARGET_DIR}" \
    --tmppath "${GENIMAGE_TMP}" \
    --inputpath "${BINARIES_DIR}" \
    --outputpath "${BINARIES_DIR}" \
    --config "${GENIMAGE_CFG}"

rm -f ${GENIMAGE_CFG}
