include $(TOPDIR)/rules.mk

PKG_NAME:=flowerss-bot
PKG_VERSION:=2020-09-12
PKG_RELEASE:=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/indes/flowerss-bot.git
PKG_SOURCE_VERSION:=96e657af9fd48cc94674d9489cda47574db26c33

PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE:=$(PKG_SOURCE_SUBDIR)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_SOURCE_SUBDIR)

PKG_BUILD_DEPENDS:=golang/host
PKG_BUILD_PARALLEL:=1
PKG_USE_MIPS16:=0

GO_PKG:=github.com/indes/flowerss-bot
GO_PKG_LDFLAGS_X:= \
	$(GO_PKG)/config.commit=$(PKG_SOURCE_VERSION) \
	$(GO_PKG)/config.date=$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/golang/golang-package.mk

define Package/$(PKG_NAME)
	SECTION:=net
	CATEGORY:=Network
	TITLE:=A telegram bot for rss reader (golang)
	DEPENDS:=$(GO_ARCH_DEPENDS)
	URL:=https://github.com/indes/flowerss-bot
	SUBMENU:=Telegram Bot
endef

define Package/$(PKG_NAME)/description
A telegram bot for rss reader (Golang)
endef

define Build/Prepare
	tar -zxvf $(DL_DIR)/$(PKG_SOURCE) -C $(BUILD_DIR)/$(PKG_NAME) --strip-components 1
endef

define Build/Configure
  
endef

define Build/Compile
	$(eval GO_PKG_BUILD_PKG:=$(GO_PKG))
	$(call GoPackage/Build/Configure)
	$(call GoPackage/Build/Compile)
	$(STAGING_DIR_HOST)/bin/upx --lzma --best $(GO_PKG_BUILD_BIN_DIR)/flowerss-bot
	chmod +wx $(GO_PKG_BUILD_BIN_DIR)/flowerss-bot
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(GO_PKG_BUILD_BIN_DIR)/flowerss-bot $(1)/usr/bin/flowerss-bot
	$(INSTALL_DIR) $(1)/home/flowerss-bot
	$(CP) ./files/config.yml.sample $(1)/home/flowerss-bot/config.yml.sample
	$(INSTALL_DIR) $(1)/lib/upgrade/keep.d
	$(CP) ./files/flowerss-bot $(1)/lib/upgrade/keep.d/flowerss-bot
endef
$(eval $(call GoBinPackage,$(PKG_NAME)))
$(eval $(call BuildPackage,$(PKG_NAME)))
