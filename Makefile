#
# Copyright (C) 2017 Xue Liu <liuxuenetmail@gmail.com>
#
# This is free software, licensed under the GPL 2 license.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libiwpaninfo
PKG_VERSION:=2017-01-20
PKG_RELEASE=$(PKG_SOURCE_VERSION)

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL=https://github.com/xueliu/iwpaninfo
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=b2aa9d548f61c7260fb5c9085bbabc0fcf8d1f6a
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz
PKG_MAINTAINER:=Xue Liu <liuxuenetmail@gmail.com>
PKG_LICENSE:=GPL-2.0

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)
	
PKG_CONFIG_DEPENDS := \
	CONFIG_PACKAGE_kmod-mac802154

include $(INCLUDE_DIR)/package.mk


define Package/libiwpaninfo
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=Generalized 802.15.4 Information Library (iwpaninfo)
  DEPENDS:=+PACKAGE_kmod-mac802154:libnl-tiny +libuci
  ABI_VERSION:=$(PKG_RELEASE)
endef

define Package/libiwpaninfo/description
  802.15.4 information library with consistent interface for nl802154.
endef


define Package/libiwpaninfo-lua
  SUBMENU:=Lua
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=libiwpaninfo Lua binding
  DEPENDS:=+libiwpaninfo +liblua
endef

define Package/libiwpaninfo-lua/description
  This is the Lua binding for the iwpaninfo library. It provides access to nl802154.
endef


define Package/iwpaninfo
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Generalized Wireless Information utility
  DEPENDS:=+libiwpaninfo
endef

define Package/iwpaninfo/description
  Command line frontend for the 802.15.4 information library.
endef


define Build/Configure
endef

IWPANINFO_BACKENDS := \
	$(if $(CONFIG_PACKAGE_kmod-mac802154),nl802154)

TARGET_CFLAGS += \
	-I$(STAGING_DIR)/usr/include/libnl-tiny \
	-I$(STAGING_DIR)/usr/include \
	-D_GNU_SOURCE

MAKE_FLAGS += \
	FPIC="$(FPIC)" \
	CFLAGS="$(TARGET_CFLAGS)" \
	LDFLAGS="$(TARGET_LDFLAGS)" \
	BACKENDS="$(IWPANINFO_BACKENDS)"

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include/iwpaninfo
	$(CP) $(PKG_BUILD_DIR)/include/iwpaninfo.h $(1)/usr/include/
	$(CP) $(PKG_BUILD_DIR)/include/iwpaninfo/* $(1)/usr/include/iwpaninfo/
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/libiwpaninfo.so $(1)/usr/lib/libiwpaninfo.so
	$(INSTALL_DIR) $(1)/usr/lib/lua
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/iwpaninfo.so $(1)/usr/lib/lua/iwpaninfo.so
endef

define Package/libiwpaninfo/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/libiwpaninfo.so $(1)/usr/lib/libiwpaninfo.so
	$(INSTALL_DIR) $(1)/usr/share/libiwpaninfo
endef

define Package/libiwpaninfo-lua/install
	$(INSTALL_DIR) $(1)/usr/lib/lua
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/iwpaninfo.so $(1)/usr/lib/lua/iwpaninfo.so
endef

define Package/iwpaninfo/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/iwpaninfo $(1)/usr/bin/iwpaninfo
endef

$(eval $(call BuildPackage,libiwpaninfo))
$(eval $(call BuildPackage,libiwpaninfo-lua))
$(eval $(call BuildPackage,iwpaninfo))
