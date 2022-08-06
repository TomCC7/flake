{config, pkgs, lib, ...}: {
  imports = [
    ./modules/xserver.nix
    ./modules/desktop.nix
    ./modules/terminal.nix
    ./modules/dev.nix
  ];

  services.xserver = {
    displayManager = {
      sddm.enable = true;
      defaultSession = "none+i3";
    };
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };

  };

  environment.systemPackages = with pkgs; [
    # autostart stuff
    dex
    playerctl
    # lxappearance
    rofi
    # libnotify
    i3lock-color
    polybarFull
    pamixer
    picom
    dunst
    # (i3pystatus.override {
    #   extraLibs = with python3.pkgs; [keyrings-alt paho-mqtt];
    # })
    # networkmanagerapplet
  ];

  # services.gvfs.enable = true;

  services.autorandr.enable = true;
}
