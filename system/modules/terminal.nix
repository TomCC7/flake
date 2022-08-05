{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
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
    htop
    killall
    ranger
    tmux
  ];
}
