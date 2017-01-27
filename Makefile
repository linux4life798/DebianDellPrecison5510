# Craig Hesling <craig@hesling.com>
# Jan 29, 2017
#

.PHONY: all firmware-iwlwifi-8260 power-management-dep

PKG_FIRMWARE_DIR     = firmware-iwlwifi-8260
PKG_FIRMWARE_CONTROL = $(PKG_FIRMWARE_DIR)/DEBIAN/control
PKG_FIRMWARE_NAME    = $(shell awk '/^Package: /{print $$2}' $(PKG_FIRMWARE_CONTROL))
PKG_FIRMWARE_VER     = $(shell awk '/^Version: /{print $$2}' $(PKG_FIRMWARE_CONTROL))
PKG_FIRMWARE_ARCH    = $(shell awk '/^Architecture: /{print $$2}' $(PKG_FIRMWARE_CONTROL))
PKG_FIRMWARE_FILE    = $(PKG_FIRMWARE_NAME)_$(PKG_FIRMWARE_VER)_$(PKG_FIRMWARE_ARCH).deb

PKG_PWR_MAN_DEP_DIR = ./
PKG_PWR_MAN_DEP_CONTROL = $(PKG_PWR_MAN_DEP_DIR)/power-management-dep.equivs
PKG_PWR_MAN_DEP_NAME = $(shell awk '/^Package: /{print $$2}' $(PKG_PWR_MAN_DEP_CONTROL))
PKG_PWR_MAN_DEP_VER = $(shell awk '/^Version: /{print $$2}' $(PKG_PWR_MAN_DEP_CONTROL))
PKG_PWR_MAN_DEP_ARCH = $(shell awk '/^Architecture: /{print $$2}' $(PKG_PWR_MAN_DEP_CONTROL))
PKG_PWR_MAN_DEP_FILE    = $(PKG_PWR_MAN_DEP_NAME)_$(PKG_PWR_MAN_DEP_VER)_$(PKG_PWR_MAN_DEP_ARCH).deb

all: firmware-iwlwifi-8260 power-management-dep

# These virtual targets depend on the package file name, which in turn are
# composed of the content of the control files. Therefore, nothing will
# be made unless the version or arch changes in the control files.

firmware-iwlwifi-8260: builds/$(PKG_FIRMWARE_NAME)_$(PKG_FIRMWARE_VER)_$(PKG_FIRMWARE_ARCH).deb
power-management-dep: builds/$(PKG_PWR_MAN_DEP_NAME)_$(PKG_PWR_MAN_DEP_VER)_$(PKG_PWR_MAN_DEP_ARCH).deb

# Git submodule with the latest firmware ucode
LINUX_FIRMWARE_DIR := linux-firmware

builds/$(PKG_FIRMWARE_FILE):
	# Clean out old firmware file
	rm -rf $(PKG_FIRMWARE_DIR)/lib
	# Copy over firmware binaries
	mkdir -p $(PKG_FIRMWARE_DIR)/lib/firmware
	cp $(LINUX_FIRMWARE_DIR)/iwlwifi-8000C-21.ucode $(PKG_FIRMWARE_DIR)/lib/firmware/
	cp $(LINUX_FIRMWARE_DIR)/iwlwifi-8000C-22.ucode $(PKG_FIRMWARE_DIR)/lib/firmware/
	cp $(LINUX_FIRMWARE_DIR)/iwlwifi-8000C-27.ucode $(PKG_FIRMWARE_DIR)/lib/firmware/
	# Generating the md5sums inside the package
	cd $(PKG_FIRMWARE_DIR) ;	find * -type f | grep -v DEBIAN | xargs md5sum | tee DEBIAN/md5sums
	# Build the firmware-iwlwifi-8260 package
	fakeroot dpkg -b $(PKG_FIRMWARE_DIR) $(PKG_FIRMWARE_FILE)
	# Move the built package into the builds directory
	mv $(PKG_FIRMWARE_FILE) builds/

builds/$(PKG_PWR_MAN_DEP_FILE):
	# Build the power-management-dep package
	cd $(PKG_PWR_MAN_DEP_DIR); equivs-build $(shell basename $(PKG_PWR_MAN_DEP_CONTROL))
	# Move the built package into the builds directory
	mv $(PKG_PWR_MAN_DEP_DIR)/$(PKG_PWR_MAN_DEP_FILE) builds/
