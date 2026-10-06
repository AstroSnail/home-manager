{ lib, writeShellApplication, git }:

writeShellApplication {
  name = "github-clone";
  runtimeInputs = [ git ];
  text = lib.readFile ./github-clone.sh;
}
