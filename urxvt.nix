{ config, ... }: {
  xresources.properties = let xres = config.xresources.properties; background = "black"; foreground = "gray90"; borderColor = "gray90"; in {
    # urxvt doesn't look at resource classes
    # so we have to set the resource instances directly
    # TODO: wtf infinite recursion?
    #"URxvt.background" = xres."*Background";
    #"URxvt.pointerColor2" = xres."*Background";
    #"URxvt.foreground" = xres."*Foreground";
    #"URxvt.pointerColor" = xres."*Foreground";
    #"URxvt.borderColor" = xres."*BorderColor";
    "URxvt.background" = background;
    "URxvt.pointerColor2" = background;
    "URxvt.foreground" = foreground;
    "URxvt.pointerColor" = foreground;
    #"URxvt.borderColor" = borderColor;
    # urxvt uses the same color for internal and external borders
    "URxvt.borderColor" = background;

    "URxvt.font" = "xft:Dina:size=10";
    "URxvt.scrollBar" = false;
    "URxvt.scrollBar_right" = true;
    "URxvt.scrollColor" = foreground;
    "URxvt.scrollstyle" = "xterm";
    "URxvt.scrollTtyKeypress" = true;
    "URxvt.scrollTtyOutput" = false;
    "URxvt.scrollWithBuffer" = true;
    "URxvt.urgentOnBell" = true;
  };
}
