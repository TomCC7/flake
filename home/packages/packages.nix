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
    # MISC
    arandr

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

    # fonts
    nerdfonts


    # desktop
    rofi
    polybar
    qutebrowser
    tdesktop

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
