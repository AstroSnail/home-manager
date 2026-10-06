{ lib, writeShellApplication, dmenu, dmenu-wayland, pass, xdotool, ydotool }:

writeShellApplication {
  name = "passmenu-patient";
  #runtimeInputs = [ dmenu-wayland pass ydotool ];
  runtimeInputs = [ dmenu pass xdotool ydotool ];
  text = lib.readFile ./passmenu-patient.bash;
}
