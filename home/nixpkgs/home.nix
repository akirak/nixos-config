{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ripgrep
    # Needed by my herbstluftwm config
    rofi
    gxmessage
    # Needed for my Emacs configuration
    gcc
  ];

  programs.emacs = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Akira Komamura";
    userEmail = "akira.komamura@gmail.com";
    aliases = {
      co = "checkout";
    };
    extraConfig = {
      github = {
        user = "akirak";
      };
    };
  };

  programs.firefox = {
    enable = true;
    enableIcedTea = false;
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };

  systemd.user.services = {
    syncthing = {
      Unit = {
        Description = "Run Syncthing daemon";
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.syncthing}/bin/syncthing -no-browser";
      };
      Install = {
        WantedBy = ["hm-graphical-session.service"];
      };
    };
  };

  # Configure ~/.xinitrc.
  xsession = {
    enable = true;
    windowManager.command =
      "${pkgs.herbstluftwm}/bin/herbstluftwm --locked";
    scriptPath = ".xinitrc";
  };

  # Also configure the setkbmap service.
  home.keyboard = {
    layout = "us";
    options = [ "ctrl:nocaps" ];
  };

  home.file = {
    ".emacs".text = ''
(setq custom-file "~/.custom.el")
(when (file-exists-p custom-file)
  (load-file custom-file))
(setq akirak/use-personal-configuration t)
(load-file (expand-file-name "init.el" user-emacs-directory))
    '';

    # TODO: Create a symbolic link to ~/.nix-profile/share/applications/emacs.desktop
    # ".local/share/applications/emacs.desktop".source =
  };

  programs.home-manager = {
    enable = true;
    path = "/etc/nixos/home-manager";
  };
}

# Use compile to rebuild the home from inside Emacs.

# Local Variables:
# compile-command: "home-manager switch"
# End:
