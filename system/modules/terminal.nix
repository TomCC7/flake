{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # monitoring
    htop
    nvtop
    gotop
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
    pandoc
    exa
    killall
    ranger
    tmux
  ];
}
