{
  nixpkgs.overlays = [
    (final: prev: {
      # overlaid under a different name because overriding xterm
      # directly seems to cause a large cascade of rebuilds
      xterm-toolbar =
        prev.xterm.overrideAttrs (oldattrs: {
          patches = []; # remove sixel-256.support.patch
          configureFlags = oldattrs.configureFlags ++ [
            "--enable-toolbar"
          ];
        });
    })
  ];

  xresources.properties = {
    "XTerm*vt100.decTerminalID" = 525;
    "XTerm*vt100.decGraphicsID" = 340;
    "XTerm*vt100.numColorRegisters" = 1024;

    #"XTerm.toolBar" = true;
    #"XTerm*vt100.scrollBar" = true;
    "XTerm*vt100.foreground" = "white";
    "XTerm*vt100.background" = "black";
    #"XTerm*vt100.boldColors" = false;
    #"XTerm*vt100.cursorBar" = true;
    "XTerm*vt100.cursorBlink" = true;
    #"XTerm*vt100.cursorUnderLine" = true;
    #"XTerm*vt100.showWrapMarks" = true;

    #"XTerm*vt100.faceName" =
    #  "x:-misc-fixed-medium-r-normal--18-120-100-100-c-90-iso10646-1";
    #"XTerm*vt100.faceNameDoublesize" =
    #  "x:-misc-fixed-medium-r-normal-ja-18-120-100-100-c-180-iso10646-1";
    #"XTerm*vt100.faceName" = "Unifont";
    #"XTerm*vt100.faceSize" = "12";
    "XTerm*vt100.faceName" = "Dina";
    "XTerm*vt100.faceSize" = "10";

    "XTerm*vt100.bellIsUrgent" = true;
    #"XTerm*vt100.visualBell" = true;
    #"XTerm*vt100.visualBellLine" = true;

    "XTerm*vt100.scrollKey" = true;
    "XTerm*vt100.scrollTtyOutput" = false;
    #"XTerm*vt100.allowScrollLock" = true;
    "XTerm*vt100.autoScrollLock" = true;
    "XTerm*vt100.cdXtraScroll" = true;
    "XTerm.buffered" = true;
    #"XTerm*vt100.jumpScroll" = true;
    #"XTerm*vt100.fastScroll" = false;

    "XTerm*vt100.locale" = true;
    "XTerm*vt100.eightBitInput" = false;
    #"XTerm*vt100.modifyOtherKeys" = 2;
    #"XTerm.ttyModes" = "erase ^h";
    "XTerm*vt100.backarrowKey" = false;

    "XTerm*vt100.translations" = ''
      #override \n\
         Ctrl ~Meta  Shift <Key>C  : copy-selection(CLIPBOARD, CUT_BUFFER1) \n\
         Ctrl ~Meta  Shift <Key>V  : insert-selection(CLIPBOARD, CUT_BUFFER1) \n\
        ~Ctrl ~Meta ~Shift <Btn2Up>: insert-selection(PRIMARY, CUT_BUFFER0) \n\
        ~Ctrl ~Meta  Shift <Btn2Up>: insert-selection(CLIPBOARD, CUT_BUFFER1) \n\
                    ~Shift <BtnUp> : select-end(PRIMARY, CUT_BUFFER0) \n\
                     Shift <BtnUp> : select-end(CLIPBOARD, CUT_BUFFER1)
    '';
    "XTerm*vt100.scrollbar.translations" = ''
      #override \n\
        <Btn1Down>  : StartScroll(Continuous) MoveThumb() NotifyThumb() \n\
        <Btn1Motion>: MoveThumb() NotifyThumb()
    '';
  };
}
