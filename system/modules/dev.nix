{ config, lib, pkgs, ... }:

with pkgs;
let
  my-python-packages = python-packages: with python-packages; [
    requests
    numpy
    ipython
    poetry
    jupyter
    # i3-quickterm
  ];
  my-python = python3.withPackages my-python-packages;
in
{
  # docker
  virtualisation.docker = {
    enable = true;
    enableNvidia = true; # enable nvidia container support
  };

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

  environment.systemPackages = with pkgs; [
    # c & c++
    cmake
    gnumake
    gcc
    clang_14
    clang-tools
    libtool
    cling

    # python & julia
    my-python
    julia-bin

    # plantuml
    plantuml
    jre8
    graphviz

    # latex
    texlive.combined.scheme-full

    # editors
    vscode-with-extensions
  ];

  # Android {{
  programs.adb.enable = true;
  users.users.cc.extraGroups = ["adbusers"];
  # }}
}
