{ pkgs, ... }:

{
    # emacs
  programs.emacs = {
      enable = true;
      extraPackages = epkgs: [
        epkgs.vterm
        epkgs.magit
      ];
  };
}
