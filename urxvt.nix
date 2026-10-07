{ config, pkgs, ... }@args:

{
  programs.urxvt.enable = true;
  programs.urxvt.fonts = [ "xft:Dina:size=10" ];
  programs.urxvt.scroll.lines = 0;
  # TODO: wtf infinite recursion?
  # programs.urxvt.extraConfig.background = config.xresources.properties."*Background";
  # programs.urxvt.extraConfig.foreground = config.xresources.properties."*Foreground";
  programs.urxvt.extraConfig.background = "black"; # "*Background"
  programs.urxvt.extraConfig.foreground = "gray90"; # "*Foreground"
  programs.urxvt.extraConfig.urgentOnBell = true;
}
