# Makefile for installing NixOS

# The installation target
# TODO: Make this customizable at runtime
TARGET = machine-victoria

# The mount point of the root file system
ROOT = /mnt

# The home directory of the target system
USER_HOME = $(ROOT)/home/nix

.PHONY: nixbld install config clean

install: config nixbld
	sudo PATH="$(PATH)" NIX_PATH="$(NIX_PATH)" \
		`which nixos-install` --root $(ROOT)

# TODO: Make this step optional
	sudo sh scripts/generate-wpa-supplicant.sh

	ln -s /etc/nixos/home $(USER_HOME)/.config
	ln -s /etc/nixos $(USER_HOME)/nix

# Generate the configuration files of NixOS
config: hardware-configuration.nix configuration.nix

hardware-configuration.nix:
	[ -f hardware-configuration.nix ] \
	|| `which nixos-generate-config` --show-hardware-config --root /mnt > hardware-configuration.nix

configuration.nix:
	ln -s $(TARGET).nix configuration.nix

# Create nixbld user and group
nixbld:
	getent group nixbld >/dev/null || sudo groupadd -g 30000 nixbld
	getent passwd nixbld >/dev/null || sudo useradd -u 30000 -g nixbld -G nixbld nixbld

clean:
# Clean up nixbld user and group
	! getent passwd nixbld >/dev/null || sudo userdel nixbld
	! getent group nixbld >/dev/null || sudo groupdel nixbld
