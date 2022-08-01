{ pkgs, ... }:

with pkgs;
let
  default-python = python3.withPackages (python-packages:
    with python-packages; [
      pip
      setuptools
      wheel
      virtualenv
    ]);

in {
  home.packages = with pkgs; [
    # display
    arandr
    autorandr

    # TERMINAL
    neovim
    alacritty
    neofetch
    zip
    unrar
    unzip
    tree
    gnupg
    aria2
    imagemagick
    feh
    pandoc
    exa
    htop
    killall
    ranger
    tmux

    # fonts
    nerdfonts
    wqy_zenhei
    wqy_microhei
    material-design-icons
    unifont


    # desktop
    rofi
    polybarFull
    qutebrowser
    tdesktop
    picom
    xbps
    mpd

    # build
    cmake
    gnumake
    gcc
    libtool

    # DEFAULT
    pavucontrol
    discord
    vlc

    #spotify
    blueman
  ];
    # emacs
  programs.emacs = {
      enable = true;
      extraPackages = epkgs: [
        epkgs.vterm
        epkgs.magit
      ];
  };
}
