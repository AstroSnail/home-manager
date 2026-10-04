{ config, pkgs, ... }@args:

{
  nixpkgs.overlays = [
    (final: prev: {
      rxvt-unicode-unwrapped = prev.rxvt-unicode-unwrapped.overrideAttrs (finalAttrs: prevAttrs: {
        patches = (prevAttrs.patches or []) ++ [ ./urxvt-compile.patch ];
      });
    })
  ];

  programs.urxvt.enable = true;
  programs.urxvt.fonts = [ "xft:Dina:size=10" ];
  programs.urxvt.scroll.lines = 0;
  # TODO: wtf infinite recursion?
  # programs.urxvt.extraConfig.background = config.xresources.properties."*Background";
  # programs.urxvt.extraConfig.foreground = config.xresources.properties."*Foreground";
  programs.urxvt.extraConfig.background = "black"; # "*Background"
  programs.urxvt.extraConfig.foreground = "gray90"; # "*Foreground"
  programs.urxvt.extraConfig.urgentOnBell = true;

  # xresources.properties = let
  #   # TODO: wtf infinite recursion?
  #   #xres = config.xresources.properties;
  #   configJank = import ./home.nix args;
  #   xres = configJank.xresources.properties;
  # in {
  #   # urxvt doesn't look at resource classes
  #   # so we have to set the resource instances directly
  #   "URxvt.background" = xres."*Background";
  #   "URxvt.foreground" = xres."*Foreground";

  #   "URxvt.font" = "xft:Dina:size=10";

  #   "URxvt.urgentOnBell" = true;

  #   "URxvt.saveLines" = 0;
  #   # "URxvt.scrollBar" = false;
  #   # "URxvt.scrollBar_right" = true;
  #   # "URxvt.scrollColor" = xres."*Foreground";
  #   # "URxvt.scrollstyle" = "xterm";
  #   # "URxvt.scrollTtyKeypress" = true;
  #   # "URxvt.scrollTtyOutput" = false;
  #   # "URxvt.scrollWithBuffer" = true;
  # };
}
