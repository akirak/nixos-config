{ config, lib, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    # Use the US keyboard layout.
    layout = "us";

    # Use CapsLock as Ctrl.
    xkbOptions = "ctrl:nocaps";

    # Forcibly kill X with Ctrl+Alt+Backspace.
    enableCtrlAltBackspace = true;

    # Enable touchpad support.
    # libinput.enable = true;

  };
}
