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
    font-awesome
    noto-fonts
    nerdfonts
    wqy_zenhei
    wqy_microhei
    material-design-icons
    unifont
  ];

  environment.systemPackages = with pkgs; [

    # desktop
    alacritty
    pcmanfm
    flameshot

    # softwares
    discord
    vlc
    qutebrowser
    tdesktop
    slack
    mattermost-desktop
    # cider
  ];
}
