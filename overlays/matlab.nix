flake-overlays:

{ config, pkgs, options, lib, ... }:
{
  nixpkgs.overlays = [
    (
      final: prev: {
        # Your own overlays...
      }
    )
  ] ++ flake-overlays;
}
