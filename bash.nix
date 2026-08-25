{ config, lib, options, pkgs, ... }:

lib.mkMerge [
  {
    programs.bash.enable = true;

    programs.bash.historyControl = [ "ignoredups" "ignorespace" ];
    programs.bash.historyFile = "${config.xdg.dataHome}/bash_history";
    programs.bash.historyFileSize = null;
    programs.bash.historySize = -1;

    programs.bash.shellOptions = [
      # " -o hashall"
      " -o noclobber"
      # " -o notify"
      # " -o vi"
      "checkjobs"
      "histappend"
      "histreedit"
      "histverify"
    ];

    programs.bash.initExtra = ''
      HISTTIMEFORMAT='%F %T '
      PROMPT_DIRTRIM=2
    '';
  }

  {
    # programs.bash.profileExtra = ''
    #   # PATH=$PATH:${config.home.homeDirectory}/.foundry/bin
    # '';

    programs.bash.initExtra = ''
      . ${./bash-funcs.bash}
      . ${./bash-prompt.bash}

      # make CTRL-S usable in bash
      stty -ixon

      # sound the bell to check that it's working
      # tput bel

      # open a fortune cookie!
      # specifically, something vicious from vex~
      fortune ${pkgs.fortunes-vex}/share/games/fortunes/vex
    '';
  }

  {
    programs.bash.enableCompletion = true;
    # works around old problems in a very annoying way
    programs.bash.enableVteIntegration = false;
    # default config is doomed to be perpetually out of date
    programs.dircolors.enable = false;

    programs.bash.initExtra = ''
      eval "$(${lib.getExe' pkgs.coreutils "dircolors"})"
      . ${pkgs.vte}/etc/profile.d/vte.sh
    '';
  }
]
