{ config, lib, pkgs, ... }:

{
  imports = [
    ./modules/peripherals.nix
  ];
}
