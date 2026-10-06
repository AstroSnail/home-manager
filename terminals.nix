{ pkgs, ... }:

{
  imports = [
    ./urxvt.nix
    ./xterm.nix
    ./zutty.nix
  ];

  nixpkgs.overlays = [
    (final: prev: {

      pangoterm = final.callPackage ./pkgs/pangoterm.nix { };

      terminfo-erry = final.callPackage ./pkgs/terminfo-erry.nix { };

      vte = prev.vte.overrideAttrs (finalAttrs: prevAttrs: {
        patches = (prevAttrs.patches or []) ++ [ ./patches/vte-term.patch ];
      });

    })
  ];

  home.packages = [
    pkgs.kdePackages.konsole
    pkgs.lxterminal
    pkgs.pangoterm
  ];

  home.file.".terminfo".source = "${pkgs.terminfo-erry}/share/terminfo";

  programs.kitty.enable = true;

  xdg.configFile."pangoterm.cfg".source = ./pangoterm.cfg;
}
