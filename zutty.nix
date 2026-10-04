{ lib, pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      zutty = prev.zutty.overrideAttrs (finalAttrs: prevAttrs: {
        patches = (prevAttrs.patches or []) ++ [
          ./zutty-compile.patch
          ./zutty-term.patch
        ];
        meta = prevAttrs.meta // {
          broken = false;
        };
      });
    })
  ];

  home.packages = [
    pkgs.zutty
  ];

  xresources.properties = {
    # zutty doesn't support x11 color names
    # so we have to convert them to #rrggbb
    "Zutty.bg" = "#000000";
    "Zutty.fg" = "#e5e5e5";

    #"Zutty.font" = "Dina"; # uses Medium instead of Regular, zutty can't find it
    #"Zutty.fontsize" = 10; # pixels, not points. also the line spacing is wrong
    #"Zutty.dwfont" = ""; # idk

    "Zutty.bellIsUrgent" = true;

    "Zutty.saveLines" = 0;
  };
}
