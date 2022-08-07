{ config, lib, pkgs, ... }:

with pkgs;
let
  my-python-packages = python-packages: with python-packages; [
    requests
    numpy
    ipython
    poetry
    # i3-quickterm
  ];
  my-python = python3.withPackages my-python-packages;
in
{
  virtualisation.docker = {
    enable = true;
  };
  environment.systemPackages = with pkgs; [
    # c & c++
    cmake
    gnumake
    gcc
    libtool
    # python
    my-python
    julia-bin

    # editors
    vscode-with-extensions
  ];

  # Android {{
  programs.adb.enable = true;
  users.users.cc.extraGroups = ["adbusers"];
  # }}
}
