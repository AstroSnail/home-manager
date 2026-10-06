{ lib, writeShellApplication }:

writeShellApplication {
  name = "noexec";
  text = lib.readFile ./noexec.sh;
};
