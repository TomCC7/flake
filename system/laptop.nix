{ config, lib, pkgs, ... }:

{
  imports = [
    ./modules/peripherals.nix
  ];
  services.tlp = {
    enable = true;
    settings = {
      # TLP_ENABLE = 1;
      # TLP_WARN_LEVEL=3;

      # CPU_SCALING_GOVERNOR_ON_AC = "performance";
      # CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    };
  };
}
