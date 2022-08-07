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
    enable = true;
    userName = "C.C";
    userEmail = "cctom@umich.edu";
  };

  xresources.properties = {
    "xft.dpi" = 144;
  };

  xresources.extraConfig = builtins.readFile (
    pkgs.fetchFromGitHub {
      owner = "dracula";
      repo = "xresources";
      rev = "539ef24e9b0c5498a82d59bfa2bad9b618d832a3";
      sha256 = "sha256-6fltsAluqOqYIh2NX0I/LC3WCWkb9Fn8PH6LNLBQbrY=";
    } + "/Xresources"
  );

  gtk = {
    enable = false;
    theme = {
      name = "Materia-dark";
      package = pkgs.materia-theme;
    };
  };
}
