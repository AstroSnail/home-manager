{ lib, writeShellApplication, vim-drop }:

writeShellApplication {
  name = "vim-edit";
  runtimeInputs = [ vim-drop ];
  text = lib.readFile ./vim-edit.sh;
}
