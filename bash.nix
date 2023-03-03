{ config, ... }:

{
  programs.bash.enable = true;
  programs.bash.historyFile = "${config.xdg.stateHome}/bash_history";
  programs.bash.initExtra = ''
    PATH=$PATH:${config.home.homeDirectory}/.foundry/bin
  '';
}
