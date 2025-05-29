{ pkgs, ... }:

let

  terminfo-erry = pkgs.runCommand "terminfo-erry" {
    src = ./terminfo.src;
    tic = "${pkgs.ncurses}/bin/tic";
  } ''
    mkdir --parents "$out/share/terminfo"
    "$tic" -x -o "$out/share/terminfo" -v "$src"
  '';

in {
  home.file.".terminfo".source = "${terminfo-erry}/share/terminfo";
}
