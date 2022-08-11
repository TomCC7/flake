{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # monitoring
    htop
    nvtop
    bottom
    s-tui
    git
    curl
    stow
    zsh
    neovim
    neofetch
    zip
    unrar
    unzip
    tree
    aria2
    imagemagick
    feh
    exa
    killall
    ranger
    tmux
    wakatime
    pciutils
    jq
    usbutils
    cloc
  ];

  programs.autojump.enable = true;
}
