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
    ln -s $HOME/nixos/home/nixpkgs $HOME/.config/nixpkgs
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
