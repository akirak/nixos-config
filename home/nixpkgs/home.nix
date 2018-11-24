{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Akira Komamura";
    userEmail = "akira.komamura@gmail.com";
#    extraConfig = {
#      "github.user" = "akirak"; 
#    };
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

  programs.home-manager = {
    enable = true;
    path = "/etc/nixos/home-manager";
  };
}
