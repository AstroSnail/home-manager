{ lib, writeShellApplication, jq }:

writeShellApplication {
  name = "vim-drop";
  runtimeInputs = [ jq ];
  text = lib.readFile ./vim-drop.sh;
}
