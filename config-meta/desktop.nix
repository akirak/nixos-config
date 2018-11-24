{ config, lib, pkgs, ... }:

{
  imports =
  [
    ../config/base.nix
    ../config/x11.nix
    # ../config/network-manager.nix
    # ../config/sshd.nix
    # ../config/sound.nix
  ];

  # firewall settings
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
}
