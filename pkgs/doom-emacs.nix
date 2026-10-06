{
  lib, writeShellApplication, agda, bash, emacsNativeComp, emacs, fd,
  fontconfig, git, gnugrep, pandoc, ripgrep, shellcheck,
}:

writeShellApplication {
  name = "doom";
  runtimeInputs = [
    #agda
    bash
    #emacsNativeComp
    emacs
    fd
    fontconfig
    git
    gnugrep
    pandoc
    ripgrep
    shellcheck
  ];
  text = lib.readFile ./doom.sh;
}
