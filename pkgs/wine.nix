{ name ? "wine", lib, writeShellApplication, wine, winetricks }:

writeShellApplication {
  inherit name;
  runtimeInputs = [ wine winetricks ];
  text = lib.readFile ./wine.sh;
}
