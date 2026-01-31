################################################################################
#
# litex-etherbone-server
#
################################################################################

LITEX_ETHERBONE_SERVER_VERSION = c07cf1a33959287b2557a679302fb1ead16d72f0
LITEX_ETHERBONE_SERVER_SITE = https://github.com/trabucayre/litex_etherbone_server.git
LITEX_ETHERBONE_SERVER_SITE_METHOD = git
LITEX_ETHERBONE_SERVER_LICENSE = Apache-2.0
LITEX_ETHERBONE_SERVER_LICENSE_FILES = LICENSE

define LITEX_ETHERBONE_SERVER_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE1) \
		CC=$(TARGET_CC) $(TARGET_LDFLAGS) $(TARGET_LDFLAGS) \
		-C $(@D) all
endef

define LITEX_ETHERBONE_SERVER_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 755 $(@D)/build/litex_etherbone_server $(TARGET_DIR)/usr/bin/litex_etherbone_server
endef

$(eval $(generic-package))
