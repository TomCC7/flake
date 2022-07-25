{ config, pkgs, lib, ... }:
{
  home.username = "cc";
  home.homeDirectory = "/home/cc";
  home.stateVersion = "22.11";

  imports = [ ./packages/packages.nix ./configs/configs.nix];
}
