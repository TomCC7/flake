{ config, lib, pkgs, ... }:

{
  imports = [
  ];

  # using headset buttons to control media
  services.mpris-proxy.enable = true;

  home.pointerCursor = {
    x11.enable = true;
    size = 40;
    package = pkgs.nur.repos.ambroisie.vimix-cursors;
    name = "Vimix-white-cursors";
  };

  programs.home-manager.enable = true;

  programs.git = {
    package = pkgs.gitAndTools.gitFull;
    enalbe = true;
    userName = "C.C";
    userEmail = "cctom@umich.edu";
  };
}
