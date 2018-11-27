{ config, lib, pkgs, ... }:

{
  services.syncthing = {
    enable = true;

    # Enable systemd service.
    systemService = true;

    user = "nix";
    group = "nix";
    dataDir = "/home/nix/.local/share/syncthing";
  };
}
