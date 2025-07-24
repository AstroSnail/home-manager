{ config, lib, options, ... }:

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
    " -o vi"
    "histreedit"
    "histverify"
  ];
  programs.bash.initExtra = ''
    HISTTIMEFORMAT=

    # vim :terminal emulates xterm, and correctly changes TERM to xterm when it
    # doesn't begin with xterm already.
    # but that method doesn't handle more exotic xterm descriptions like
    # xterm-vt220, which vim :terminal doesn't emulate.
    # it should set TERM unconditionally!
    if [[ -n $VIM_TERMINAL ]]
    then
      if [[ $COLORS -ge 256 ]]
      then TERM=xterm-256color
      else TERM=xterm
      fi
    fi

    # disable ^S magic so bash can use it
    stty -ixon

    . ${./bash-indicator.bash}
    . ${./bash-prompt.bash}
    . ${./bash-title.bash}

    nomsh() {
      nom build --no-link --print-out-paths "$@"
      nom shell "$@"
    }

    # sound the bell to check that it's working
    #tput bel
  '';
  programs.bash.profileExtra = ''
    PATH=$PATH:${config.home.homeDirectory}/.foundry/bin
  '';
}
