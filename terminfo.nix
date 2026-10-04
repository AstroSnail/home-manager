{ lib, pkgs, ... }:

let


in {
  nixpkgs.overlays = [
    (final: prev: {
      terminfo-erry = final.runCommand "terminfo-erry" {
        src = ./terminfo.src;
        tic = lib.getExe' final.ncurses "tic";
      } ''
        mkdir --parents "$out/share/terminfo"
        "$tic" -x -o "$out/share/terminfo" -v "$src"
      '';
    })
  ];

  home.file.".terminfo".source = "${pkgs.terminfo-erry}/share/terminfo";
}
