{ lib, runCommand, ncurses }:

runCommand "terminfo-erry" {
  src = ./terminfo-erry.src;
  tic = lib.getExe' ncurses "tic";
} ''
  mkdir --parents "$out/share/terminfo"
  "$tic" -x -o "$out/share/terminfo" -v "$src"
''
