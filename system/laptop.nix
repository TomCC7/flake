{ config, lib, pkgs, ... }:

{
  imports = [
    ./modules/peripherals.nix
  ];

  services.xserver = {
    libinput = {
      enable = true;
      touchpad = {
        tapping = true;
        naturalScrolling = true;
      };
    };
  };
}
