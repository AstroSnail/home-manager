{ lib, runCommand, ncurses }:

runCommand "terminfo-erry" {
  src = ./terminfo-erry.src;
  nativeBuildInputs = [ ncurses ];
} ''
  mkdir --parents "$out/share/terminfo"
  tic -x -o "$out/share/terminfo" -v "$src"
''
