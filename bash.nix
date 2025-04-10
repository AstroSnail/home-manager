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
    PATH=$PATH:${config.home.homeDirectory}/.foundry/bin
  '';
}
