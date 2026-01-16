{
  nixpkgs.overlays = [
    (final: prev: {
      # overlaid under a different name because overriding xterm
      # directly seems to cause a large cascade of rebuilds
      xterm-erry =
        prev.xterm.overrideAttrs (oldattrs: {
          pname = "xterm-erry";
          # remove sixel-256.support.patch
          patches = [
            # ./xterm-f1-f4.patch
            # ./xterm-fix-status-line.patch
          ];
          configureFlags = oldattrs.configureFlags ++ [
            "--enable-block-select"
            # "--enable-status-line"
            # "--enable-toolbar"
            # "--enable-trace"
          ];
        });
    })
  ];

  xresources.properties = {
    # Feature settings
    # custom TERM assumes xterm has been configured in specific ways
    # e.g. patches above and keyboardType below
    # "XTerm.termName" = "xterm-erry";
    "XTerm.termName" = "xterm-256color";
    # "XTerm*VT100.decTerminalID" = 525;
    # "XTerm*VT100.decGraphicsID" = 340;
    # "XTerm*VT100.numColorRegisters" = 1024;

    # Widget settings
    # "XTerm.toolBar" = true;
    "XTerm*menubar.borderWidth" = 1;
    "XTerm*VT100.borderWidth" = 0;
    # TODO: disable scrollbar only in alternate screen
    # "XTerm*VT100.scrollBar" = true;
    # "XTerm*VT100.rightScrollBar" = true;

    # Text settings
    # "XTerm*VT100.background" = "black";
    # "XTerm*VT100.foreground" = "gray90";
    # "XTerm*VT100.boldColors" = false;
    # "XTerm*VT100.cursorBar" = true;
    # "XTerm*VT100.cursorBlink" = true;
    # "XTerm*VT100.cursorUnderLine" = true;
    # "XTerm*VT100.showWrapMarks" = true;
    "XTerm*VT100.colorBD" = "white"; # default bold makes bright white
    "XTerm*VT100.colorBDMode" = true;
    "XTerm*VT100.veryBoldColors" = 4;
    # "XTerm*VT100.faceName" =
    #   "x:-misc-fixed-medium-r-normal--18-120-100-100-c-90-iso10646-1";
    # "XTerm*VT100.faceNameDoublesize" =
    #   "x:-misc-fixed-medium-r-normal-ja-18-120-100-100-c-180-iso10646-1";
    # "XTerm*VT100.faceName" = "Unifont";
    # "XTerm*VT100.faceSize" = "12";
    "XTerm*VT100.faceName" = "Dina";
    "XTerm*VT100.faceSize" = "10";

    # Bell settings
    "XTerm*VT100.bellIsUrgent" = true;
    "XTerm*VT100.visualBell" = true;
    "XTerm*VT100.visualBellLine" = true;

    # Scrolling settings
    "XTerm*VT100.scrollKey" = true;
    "XTerm*VT100.scrollTtyOutput" = false;
    # "XTerm*VT100.allowScrollLock" = true;
    "XTerm*VT100.autoScrollLock" = true;
    "XTerm*VT100.cdXtraScroll" = true;
    # "XTerm.buffered" = true; # holy shit this causes SO MANY GLITCHES
    # "XTerm*VT100.jumpScroll" = true;
    # "XTerm*VT100.fastScroll" = true;
    # "XTerm*VT100.multiScroll" = true;

    # Input settings
    # "XTerm.keyboardType" = "vt220";
    # "XTerm.ttyModes" = "erase ^h";
    # ncurses ships terminfo with xterm+kbs set to DEL when it's built
    # on a linux system, but xterm default-enables backarrowKey at
    # build time (ie backarrow=BS).
    "XTerm*VT100.backarrowKey" = false;
    # "XTerm*VT100.eightBitInput" = false;
    "XTerm*VT100.locale" = true;
    "XTerm*VT100.metaSendsEscape" = true;
    # "XTerm*VT100.modifyOtherKeys" = 2;

    # Translation settings
    "XTerm.omitTranslation" = [
      # "shift-fonts" # gets in the way of shift+kp_add in vt220 keyboard mode
    ];
    # use left-shift to choose between pri and clip
    # flawed: this only works correctly when the window is focused and the
    #         pointer is over the window.
    # workaround: release and re-press shift before releasing the mouse
    #             button, listen/watch out for MinorError bells.
    "XTerm*VT100.translations" = ''
      #override \n\
      <KeyPress> Shift_L: set-select(on) \n\
      <KeyRelease> Shift_L: set-select(off)'';
  };
}
