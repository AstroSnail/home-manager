{ config, lib, pkgs, ... }:

let
  floatingAppIds =
    [ "^com\\.github\\.wwmm\\.easyeffects$" "^pavucontrol$" "^pcsx2$" ];
  floatingClasses = [
    "\\.exe$"
    "^Dwarf_Fortress$"
    "^ffplay$"
    "^Flashplayer$"
    "^Ledger Live$"
    "^love$"
    "^MEGAsync$"
    "^Minetest$"
    "^Mojosetup$"
    "^\\.scrcpy-wrapped$"
    "^Steam$"
    "^steam$"
    "^Terraria\\.bin\\.x86_64$"
  ];
  #floatingTitles = [ "Rigs of Rods" ];
  fonts = {
    #names = [ "Hack" ];
    size = 10.0;
  };

in {
  wayland.windowManager.sway = {
    enable = true;
    package = null;
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
      { app_id = lib.concatStringsSep "|" floatingAppIds; }
      { class = lib.concatStringsSep "|" floatingClasses; }
    ];
    config.floating.modifier = "Mod4";
    config.floating.titlebar = true;
    config.focus.followMouse = false;
    config.fonts = fonts;
    config.gaps.inner = 8;
    config.input."4152:4610:SteelSeries_SteelSeries_Apex_Gaming_Keyboard" = {
      #xkb_layout = "pt";
      xkb_layout = "us";
      xkb_variant = "colemak_dh_iso";
      xkb_options = "caps:escape,compose:menu-altgr";
      xkb_model = "pc105";
    };
    config.input."type:Mouse".accel_profile = "flat";
    config.input."type:Mouse".pointer_accel = "0";
    config.keybindings."Mod1+Escape" = "mode magic";
    config.window.titlebar = true;
    extraConfig = (lib.readFile ./magicmode.conf) + ''
      include /etc/sway/config.d/*
    '';
    #config.output."*".background = "${config.xdg.userDirs.pictures}/draw.icynet.eu-canvas.png center #8F8F8F";
    #config.output."*".background = "${config.xdg.userDirs.pictures}/Fac6kyRUEAAMtiJ.jpg fill #8F8F8F";
    #config.output."*".background = "${config.xdg.userDirs.pictures}/FnQswpzX0AIt0uP.jpg fill #8F8F8F";
    config.output."Samsung Electric Company C24FG7x HTNK700265" = {
      mode = "1920x1080@144Hz";
      position = "0 0";
      #position = "1366 0";
      #adaptive_sync = "on";
      background =
        "${config.xdg.userDirs.pictures}/FnQswpzX0AIt0uP.jpg fill #8F8F8F";
    };
    config.output."Samsung Electric Company SAMSUNG Unknown" = {
      mode = "1366x768@60Hz";
      position = "1920 0";
      #position = "0 312";
      background =
        "${config.xdg.userDirs.pictures}/upload_528af259f560c1e462768d8662448ebf.png fill #8F8F8F";
    };
    #config.output."Integrated Tech Express Inc HDMI2VGAV121 0x0000FF36" = {
    #  disable = "";
    #  mode = "640x480@75Hz";
    #  position = "1920 600";
    #};
    #config.workspaceOutputAssign = [
    #  {
    #    output = "\"Samsung Electric Company C24FG7x HTNK700265\"";
    #    workspace = "1";
    #  }
    #  {
    #    output = "\"Samsung Electric Company SAMSUNG 0x00000000\"";
    #    workspace = "2";
    #  }
    #];
  };
}
