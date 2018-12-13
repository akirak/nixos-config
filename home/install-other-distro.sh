#!/bin/sh

# If Nix is not installed, make it available
if ! which nix-env; then
    if [ ! -d $HOME/.nix-profile ]; then
        curl https://nixos.org/nix/install | sh
    fi
    . $HOME/.nix-profile/etc/profile.d/nix.sh
fi

# If make is not installed, install it
if ! which make >/dev/null 2>/dev/null; then
    nix-env -i gnumake
fi

# If the configuration directory is not available, make the directory available
if [ ! -e $HOME/.config/nixpkgs ]; then
    # Move all files in ~/.config to ~/nixos/home and remove ~/.config
    # This might not be safe, so use it with caution
    if [ -d $HOME/.config ]; then
        mv -v -t $HOME/nixos/home $HOME/.config/*.* $HOME/.config/*
        rmdir $HOME/.config
    fi
    ln -s $HOME/nixos/home $HOME/.config

    # This is safer, but not all config files are available in the target system
    # ln -s $HOME/nixos/home/nixpkgs $HOME/.config/nixpkgs

    # overlayfs is not available on Crostini on Chrome OS, so
    # you can't use this:
    #
    # workdir=$(mktemp -d hm-config-overlayfsXXX)
    # mount -t overlay overlay \
    #       -o lowerdir=$HOME/nixos/home,upperdir=$HOME/.config,workdir=$workdir \
    #       $HOME/.config
fi

# Ensure that the submodules are checked out
CWD=$(pwd)
cd $HOME/nixos
git submodule update --init
cd $CWD

make install
