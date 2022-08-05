{ config, lib, pkgs, ... }:

{
  imports = [
    ./sound.nix
    ./bluetooth.nix
  ];
  # emacs
  services.emacs = {
    enable = true;
    package = pkgs.emacsPgtk;
    # defaultEditor = true;
  };

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
      sha256 = "1aplxrjsbc8bkh647ng9zla7gkndrpg61arzh9m2y4rsdpab8xlm";
    }))
  ];

  environment.systemPackages = with pkgs; [
    # fonts
    nerdfonts
    wqy_zenhei
    wqy_microhei
    material-design-icons
    unifont

    # softwares
    discord
    vlc
    alacritty

    # (emacsWithPackages {
    #   # Package is optional, defaults to pkgs.emacs
    #   package = pkgs.emacsPgtk;

    #   # Optionally provide extra packages not in the configuration file.
    #   extraEmacsPackages = epkgs: [
    #     epkgs.vterm
    #     epkgs.magit
    #   ];

    #   # Optionally override derivations.
    #   # override = epkgs: epkgs // {
    #   #   weechat = epkgs.melpaPackages.weechat.overrideAttrs(old: {
    #   #     patches = [ ./weechat-el.patch ];
    #   #   });
    #   # };
    # })
  ];

}
