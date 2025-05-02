{
  nixpkgs.overlays = [
    (final: prev: {
      # overlaid under a different name because overriding xterm
      # directly seems to cause a large cascade of rebuilds
      xterm-toolbar =
        prev.xterm.overrideAttrs (oldattrs: {
          patches = []; # remove sixel-256.support.patch
          configureFlags = oldattrs.configureFlags ++ [
            "--enable-block-select"
            "--enable-status-line"
            "--enable-toolbar"
          ];
        });
    })
  ];

  xresources.properties = {
    "XTerm*VT100.decTerminalID" = 525;
    "XTerm*VT100.decGraphicsID" = 340;
    "XTerm*VT100.numColorRegisters" = 1024;

    #"XTerm.toolBar" = true;
    #"XTerm*VT100.background" = "black";
    #"XTerm*VT100.foreground" = "gray90";
    #"XTerm*VT100.boldColors" = false;
    #"XTerm*VT100.cursorBar" = true;
    #"XTerm*VT100.cursorBlink" = true;
    #"XTerm*VT100.cursorUnderLine" = true;
    #"XTerm*VT100.showWrapMarks" = true;

    #"XTerm*VT100.faceName" =
    #  "x:-misc-fixed-medium-r-normal--18-120-100-100-c-90-iso10646-1";
    #"XTerm*VT100.faceNameDoublesize" =
    #  "x:-misc-fixed-medium-r-normal-ja-18-120-100-100-c-180-iso10646-1";
    #"XTerm*VT100.faceName" = "Unifont";
    #"XTerm*VT100.faceSize" = "12";
    "XTerm*VT100.faceName" = "Dina";
    "XTerm*VT100.faceSize" = "10";

    "XTerm*VT100.bellIsUrgent" = true;
    #"XTerm*VT100.visualBell" = true;
    #"XTerm*VT100.visualBellLine" = true;

    #"XTerm*VT100.scrollBar" = true;
    "XTerm*VT100.rightScrollBar" = true;
    "XTerm*VT100.scrollKey" = true;
    "XTerm*VT100.scrollTtyOutput" = false;
    #"XTerm*VT100.allowScrollLock" = true;
    "XTerm*VT100.autoScrollLock" = true;
    "XTerm*VT100.cdXtraScroll" = true;
    #"XTerm.buffered" = true; # holy shit this causes SO MANY GLITCHES
    #"XTerm*VT100.jumpScroll" = true;
    #"XTerm*VT100.fastScroll" = false;
    "XTerm*VT100.multiScroll" = true;

    "XTerm*VT100.locale" = true;
    "XTerm*VT100.eightBitInput" = false;
    #"XTerm*VT100.modifyOtherKeys" = 2;
    #"XTerm.ttyModes" = "erase ^h";
    "XTerm*VT100.backarrowKey" = false;

    # make middleclick-paste and select-end distinguish between shift and no-shift for clip or pri
    # add shift-ctrl-c/v for clip copy/paste
    "XTerm*VT100.translations" = ''
      #override \n\
      ~Shift ~Ctrl ~Meta <Btn2Up>: insert-selection(PRIMARY, CUT_BUFFER0) \n\
       Shift ~Ctrl ~Meta <Btn2Up>: insert-selection(CLIPBOARD, CUT_BUFFER1) \n\
      ~Shift             <BtnUp> : select-end(PRIMARY, CUT_BUFFER0) \n\
       Shift             <BtnUp> : select-end(CLIPBOARD, CUT_BUFFER1) \n\
       Shift  Ctrl ~Meta <Key>C  : copy-selection(CLIPBOARD, CUT_BUFFER1) \n\
       Shift  Ctrl ~Meta <Key>V  : insert-selection(CLIPBOARD, CUT_BUFFER1)'';
  };
}
