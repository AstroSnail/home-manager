{ pkgs, ... }:

{
  #home.file.emacs.source = builtins.fetchGit {
  #  url = "https://github.com/hlissner/doom-emacs";
  #  name = "doom-emacs";
  #  ref = "master";
  #};
  #home.file.emacs.target = ".emacs.d";

  programs.emacs.enable = true;
  programs.emacs.package = pkgs.emacsNativeComp;
  # TODO wrap emacs of its deps too?
  home.packages = [
    pkgs.fd
    pkgs.ripgrep
    pkgs.shellcheck
  ];
  programs.pandoc.enable = true;
}
