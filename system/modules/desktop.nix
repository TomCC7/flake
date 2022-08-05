{ config, lib, pkgs, ... }:

{
  imports = [
    ./sound.nix
    ./bluetooth.nix
  ];
  # emacs
  services.emacs = {
    enable = true;
    package = with pkgs; ((emacsPackagesFor emacs).emacsWithPackages (epkgs: [
      epkgs.vterm
      epkgs.magit
    ]));
    # defaultEditor = true;
  };

  nixpkgs.overlays = [
    (import (builtins.fetchGit {
      url = "https://github.com/nix-community/emacs-overlay.git";
      ref = "master";
      rev = "4a5b9fb659456b31d2c15e53694e139077920592";
    }))
  ];

  fonts.fonts = with pkgs; [
    nerdfonts
    wqy_zenhei
    wqy_microhei
    material-design-icons
    unifont
  ];

  environment.systemPackages = with pkgs; [

    # softwares
    discord
    vlc
    alacritty
    qutebrowser

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
