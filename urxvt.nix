{ config, ... }@args: {
  xresources.properties = let
    # TODO: wtf infinite recursion?
    #xres = config.xresources.properties;
    configJank = import ./home.nix args;
    xres = configJank.xresources.properties;
  in {
    # urxvt doesn't look at resource classes
    # so we have to set the resource instances directly
    "URxvt.background" = xres."*Background";
    "URxvt.foreground" = xres."*Foreground";

    "URxvt.font" = "xft:Dina:size=10";

    "URxvt.urgentOnBell" = true;

    "URxvt.scrollBar" = false;
    "URxvt.scrollBar_right" = true;
    "URxvt.scrollColor" = xres."*Foreground";
    "URxvt.scrollstyle" = "xterm";
    "URxvt.scrollTtyKeypress" = true;
    "URxvt.scrollTtyOutput" = false;
    "URxvt.scrollWithBuffer" = true;
  };
}
