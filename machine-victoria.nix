# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Use the generic configuration for X11 desktop
      config-meta/desktop.nix
    ];

  networking.hostName = "victoria"; # Define your hostname.

  environment.systemPackages = with pkgs; [
    xorg.xinit
  ];

  # As this is a desktop machine, I will use wpa_supplicant suffices
  # for establishing a wireless connection:
  networking.wireless.enable = true;

  services.xserver.videoDriver = "intel";

  # Run X without a display manager.
  # TODO: Start X using systemd
  services.xserver.autorun = false;
  services.xserver.exportConfiguration = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?
}
