# bootstrap.sh: Install NixOS from a non-NixOS Linux distribution

# The version of NixOS
nixos_version=1809

# Install Nix onto the original distribution and run the installer
curl https://nixos.org/nix/install | sh \
    && . $HOME/.nix-profile/etc/profile.d/nix.sh \
    && nix-channel --add https://nixos.org/channels/nixos-${nixos_version} nixpkgs \
    && nix-env -iE "_: with import <nixpkgs/nixos> { configuration = {}; }; with config.system.build; [ nixos-generate-config nixos-install nixos-enter manual.manpages ]" \
    && make config \
    && echo <<EOF && exec $SHELL
Configuration files have been generated.

Edit hardware-configuration.nix to suit your environment and run

  make install
EOF
