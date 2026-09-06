{ lib, pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      zutty =
        prev.zutty.overrideAttrs (finalAttrs: prevAttrs: {
          version = "git-01-a78b94d";

          src = pkgs.fetchgit {
            url = "https://git.hq.sig7.se/zutty.git";
            rev = "a78b94d4c8bb0eaef659762a714e697b28175609";
            hash = "sha256-CrAiFkgmgAFxF0vOLAcRj6iGrmzi/cUUyWfV1xOkavE=";
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
