{ config, lib, options, pkgs, ... }:

{
  programs.bash.enable = true;
  programs.bash.historySize = -1;
  programs.bash.historyFile = "${config.xdg.dataHome}/bash_history";
  programs.bash.historyFileSize = null;
  programs.bash.historyControl = [ "ignoreboth" ];
  programs.bash.shellOptions = options.programs.bash.shellOptions.default ++ [
    " -o hashall"
    " -o noclobber"
    " -o notify"
    #" -o vi"
    "histreedit"
    "histverify"
  ];
  programs.bash.initExtra = ''
    HISTTIMEFORMAT=
    PROMPT_DIRTRIM=2

    # disable ^S magic so bash can use it
    stty -ixon

    . ${./bash-prompt.bash}

    # sound the bell to check that it's working
    # tput bel

    # open a fortune cookie!
    # specifically, something vicious from vex~
    fortune ${pkgs.fortunes-vex}/share/games/fortunes/vex
  '';
  # programs.bash.profileExtra = ''
  #   PATH=$PATH:${config.home.homeDirectory}/.foundry/bin
  # '';
}
