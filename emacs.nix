{ lib, pkgs, ... }:

let
  doom-emacs = pkgs.writeShellApplication {
    name = "doom";
    runtimeInputs = [
      #pkgs.agda
      pkgs.bash
      #pkgs.emacsNativeComp
      pkgs.emacs
      pkgs.fd
      pkgs.fontconfig
      pkgs.git
      pkgs.gnugrep
      pkgs.pandoc
      pkgs.ripgrep
      pkgs.shellcheck
    ];
    text = lib.readFile ./doom.sh;
  };

in {
  #home.file.emacs.source = builtins.fetchGit {
  #  url = "https://github.com/hlissner/doom-emacs";
  #  name = "doom-emacs";
  #  ref = "master";
  #};
  #home.file.emacs.target = ".emacs.d";

  #programs.emacs.enable = true;
  #programs.emacs.package = pkgs.emacsNativeComp;
  #programs.pandoc.enable = true;

  #home.packages = [ doom-emacs ];

  nixpkgs.overlays = [ (_: _: { inherit doom-emacs; }) ];
}
