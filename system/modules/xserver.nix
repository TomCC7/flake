{ config, lib, pkgs, ... }:

{
  environment.variables = {
    GDK_SCALE = "2";
    GDK_DPI_SCALE = "0.5";
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
  };

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    dpi = 192;
    libinput = {
      enable = true;
    };

    layout = "us";
    xkbVariant = "";
  };

  environment.systemPackages = with pkgs; [
    arandr
    autorandr
    xclip
  ];
}
