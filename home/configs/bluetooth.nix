{ config, lib, pkgs, ... }:

{
  # using headset buttons to control media
  services.mpris-proxy.enable = true;
}
