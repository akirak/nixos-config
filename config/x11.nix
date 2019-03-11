{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    xorg.xinit
    alacritty
  ];

  # Run X without a display manager.
  services.xserver.autorun = false;
  services.xserver.exportConfiguration = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    # Use the US keyboard layout.
    # Ineffective when you generate ~/.xinitrc using home-manager
    layout = "us";

    # Use CapsLock as Ctrl.
    # Ineffective when you generate ~/.xinitrc using home-manager
    xkbOptions = "ctrl:nocaps";

    # Forcibly kill X with Ctrl+Alt+Backspace.
    enableCtrlAltBackspace = true;

    # Enable touchpad support.
    # libinput.enable = true;

  };

  fonts.fonts = with pkgs; [
    overpass
  ];

}
