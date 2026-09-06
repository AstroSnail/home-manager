{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      # overlaid under a different name because overriding xterm
      # directly seems to cause a large cascade of rebuilds
      xterm-erry = final.xterm.overrideAttrs (finalAttrs: prevAttrs: {
        # remove sixel-256.support.patch
        patches = [
          # ./xterm-f1-f4.patch
          # ./xterm-fix-status-line.patch
        ];
        configureFlags = prevAttrs.configureFlags ++ [
          "--enable-block-select"
          # "--enable-status-line"
          "--enable-toolbar"
          # "--enable-trace"
        ];
      });
    })
  ];

  home.packages = [
    # pkgs.xterm
    pkgs.xterm-erry
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
    "XTerm.toolBar" = true;
    # approximate adwaita dark menubar style
    "XTerm*form.background" = "gray21";
    "XTerm*menubar.background" = "gray21";
    # "XTerm*menubar.borderWidth" = 1;
    "XTerm*MenuButton.background" = "gray21";
    "XTerm*SimpleMenu*background" = "gray19";
    # "XTerm*SmeLine.foreground" = "gray17"; # hard to see
    "XTerm*VT100.borderWidth" = 0; # xterm built with toolbar has extra border
    "XTerm*Tek4014.borderWidth" = 0; # do i care about the tek window?
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
    "XTerm*VT100.visualBellDelay" = 200;
    "XTerm*VT100.visualBellLine" = true;

    # Scrolling settings
    "XTerm*VT100.saveLines" = 0;
    # "XTerm*VT100.scrollKey" = true;
    # "XTerm*VT100.scrollTtyOutput" = false;
    # allowScrollLock is not terribly useful on its own. if saveLines >= 1 and
    # is full, xterm scrolls anyway with a glitchy effect. if saveLines == 0
    # then it stops scrolling but output trashes the last line. autoScrollLock,
    # together with turning off scrollTtyOutput, makes xterm hold onto the
    # screen even as saveLines fills up, but it requires saveLines >= 1 and a
    # scroll action both to engage and disengage it. allowScrollLock: true,
    # autoScrollLock: true, saveLines: 1 and scrollTtyOutput: false all almost
    # work extremely well together, but turning off scroll-lock doesn't
    # disengage autoScrollLock, it needs a scroll-down to return to the bottom.
    # the real solution is to learn to use a pager like less. an alternative
    # solution is to use xon/xoff, but is it worth losing ctrl-s and ctrl-q?
    # "XTerm*VT100.allowScrollLock" = true;
    # "XTerm*VT100.autoScrollLock" = true;
    # "XTerm*VT100.cdXtraScroll" = true;
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
      # no saveLines? no scroll needed
      "paging"
      # "reset"
      "scroll-lock"
      "wheel-mouse"
      # gets in the way of shift+kp_add in vt220 keyboard mode
      # "shift-fonts"
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
