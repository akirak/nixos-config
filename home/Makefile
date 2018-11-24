.PHONY: install home-manager

install: home-manager

home-manager:
	which home-manager >/dev/null 2>/dev/null || nix-shell /etc/nixos/home-manager -A install
