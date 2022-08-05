{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cmake
    gnumake
    gcc
    libtool
  ];
}
