REPO_ROOT = $(HOME)/nixos

.PHONY: install home-manager

install: home-manager

home-manager:
	which home-manager >/dev/null 2>/dev/null || nix-shell $(REPO_ROOT)/home-manager -A install
