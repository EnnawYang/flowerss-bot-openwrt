include $(TOPDIR)/rules.mk

PKG_NAME:=flowerss-bot
PKG_VERSION:=v0.7.1
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/indes/flowerss-bot.git
PKG_SOURCE_VERSION:=b29f417adf3f58bf862c76b5a2e9639e176d8277

PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE:=$(PKG_SOURCE_SUBDIR)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_SOURCE_SUBDIR)

PKG_BUILD_DEPENDS:=golang/host
PKG_BUILD_PARALLEL:=1
PKG_USE_MIPS16:=0

GO_PKG:=github.com/indes/flowerss-bot
GO_PKG_LDFLAGS_X:= \
	$(GO_PKG)/config.commit=`git rev-parse --short HEAD`

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
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/root/flowerss-bot
	$(INSTALL_BIN) $(GO_PKG_BUILD_BIN_DIR)/flowerss-bot $(1)/root/flowerss-bot/flowerss-bot
	$(CP) ./files/* $(1)/root/flowerss-bot/
endef
$(eval $(call GoBinPackage,$(PKG_NAME)))
$(eval $(call BuildPackage,$(PKG_NAME)))
