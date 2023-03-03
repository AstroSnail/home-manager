{ config, lib, pkgs, ... }:

let
  floatingClasses = [
    "Dwarf_Fortress"
    "easyeffects"
    "explorer.exe"
    "ffplay"
    "Flashplayer"
    ".blueman-manager-wrapped"
    "Ledger Live"
    "love"
    "MEGAsync"
    "Minetest"
    "Mojosetup"
    "Pavucontrol"
    "Pcsx2"
    ".scrcpy-wrapped"
    "Steam"
    "steam"
    "Terraria.bin.x86_64"
  ];
  #floatingTitles = [ "Rigs of Rods" ];
  fonts = {
    #names = [ "Hack" ];
    size = 10.0;
  };

in {
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    config.bars = [{
      mode = "hide";
      fonts = fonts;
      position = "bottom";
      statusCommand = "${pkgs.i3status}/bin/i3status";
      extraConfig = ''
        modifier none
      '';
    }];
    config.floating.criteria = [
      { class = lib.concatStringsSep "|" floatingClasses; }
      #{ title = lib.concatStringsSep "|" floatingTitles; }
    ];
    config.floating.modifier = "Mod4";
    config.focus.followMouse = false;
    config.fonts = fonts;
    config.gaps.inner = 8;
    config.keybindings."Mod1+Escape" = "mode magic";
    extraConfig = (lib.readFile ./magicmode.conf) + ''
      exec --no-startup-id setxkbmap
      exec --no-startup-id feh --image-bg '#8F8F8F' --bg-fill --no-fehbg ${config.xdg.userDirs.pictures}/FnQswpzX0AIt0uP.jpg
      exec --no-startup-id blueman-applet
    '';
  };
}
