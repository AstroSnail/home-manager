{ config, lib, pkgs, ... }:

let
  floatingAppIds = [
    #"^com\\.github\\.wwmm\\.easyeffects$"
    #"^firefox$"
    #"^pavucontrol$"
    #"^pcsx2$"
    "^qemu$"
  ];
  floatingClasses = [
    "\\.exe$"
    #"^Chromium-browser$"
    "^CrossCode$"
    "^Dwarf_Fortress$"
    "^Editres$"
    "^ffplay$"
    "^Flashplayer$"
    "^Ledger Live$"
    "^love$"
    "^MEGAsync$"
    "^Minetest$"
    "^Mojosetup$"
    #"^\\.scrcpy-wrapped$"
    #"^Steam$"
    #"^steam$"
    "^Terraria\\.bin\\.x86_64$"
    "^XLoad$"
    #"^XTerm$"
  ];
  #floatingTitles = [ "Rigs of Rods" ];
  fonts = {
    #names = [ "Hack" ];
    #size = 10.0;
  };

in {
  wayland.windowManager.sway.enable = true;
  wayland.windowManager.sway.package = null;
  wayland.windowManager.sway.config.bars = [{
    mode = "hide";
    #fonts = fonts;
    fonts.names = [ "Dina" ];
    fonts.size = 10.0;
    position = "bottom";
    statusCommand = "${pkgs.i3status}/bin/i3status";
    extraConfig = ''
      modifier none
    '';
  }];
  wayland.windowManager.sway.config.colors.focused = {
    border = "#e5e5e5"; # gray90
    background = "#285577"; # default
    text = "#ffffff"; # default
    indicator = "#2e9ef4"; # default
    childBorder = "#e5e5e5"; # gray90
  };
  wayland.windowManager.sway.config.colors.focusedInactive = {
    border = "#7f7f7f"; # gray50
    background = "#5f676a"; # default
    text = "#ffffff"; # default
    indicator = "#484e50"; # default
    childBorder = "#7f7f7f"; # gray50
  };
  wayland.windowManager.sway.config.colors.unfocused = {
    border = "#333333"; # gray20
    background = "#222222"; # default
    text = "#888888"; # default
    indicator = "#292d2e"; # default (unused?)
    childBorder = "#333333"; # gray20
  };
  wayland.windowManager.sway.config.colors.urgent = {
    border = "#cd0000"; # red3
    background = "#900000"; # default
    text = "#ffffff"; # default
    indicator = "#cd0000"; # red3
    childBorder = "#cd0000"; # red3
  };
  wayland.windowManager.sway.config.floating.criteria = [
    { app_id = lib.concatStringsSep "|" floatingAppIds; }
    { class = lib.concatStringsSep "|" floatingClasses; }
  ];
  wayland.windowManager.sway.config.floating.border = 1;
  wayland.windowManager.sway.config.floating.modifier = "Mod4";
  wayland.windowManager.sway.config.floating.titlebar = true;
  wayland.windowManager.sway.config.focus.followMouse = false;
  #wayland.windowManager.sway.config.fonts = fonts;
  wayland.windowManager.sway.config.fonts.names = [ "DejaVu Serif" ];
  wayland.windowManager.sway.config.fonts.size = 9.5;
  wayland.windowManager.sway.config.gaps.inner = 8;
  wayland.windowManager.sway.config.input."4152:4610:SteelSeries_SteelSeries_Apex_Gaming_Keyboard" = {
    #xkb_layout = "pt";
    xkb_layout = "us";
    #xkb_variant = "colemak_dh_iso";
    #xkb_options = "caps:escape,compose:menu-altgr";
    xkb_variant = "altgr-weur";
    xkb_options = "caps:escape,compose:menu";
    xkb_model = "pc105";
  };
  wayland.windowManager.sway.config.input."type:pointer".accel_profile = "flat";
  wayland.windowManager.sway.config.input."type:pointer".pointer_accel = "0";
  wayland.windowManager.sway.config.keybindings."Mod1+Escape" = "mode magic";
  wayland.windowManager.sway.config.window.border = 1;
  wayland.windowManager.sway.config.window.titlebar = true;
  wayland.windowManager.sway.config.window.commands = [
    { criteria.all = true; command = "title_window_icon yes"; }
  ];
  wayland.windowManager.sway.config.workspaceLayout = "tabbed";
  wayland.windowManager.sway.extraConfig = (lib.readFile ./magicmode.conf) + ''
    titlebar_padding 4 2
    include /etc/sway/config.d/*
  '';
  #wayland.windowManager.sway.config.output."*".background = "${config.xdg.userDirs.pictures}/draw.icynet.eu-canvas.png center #8F8F8F";
  #wayland.windowManager.sway.config.output."*".background = "${config.xdg.userDirs.pictures}/Fac6kyRUEAAMtiJ.jpg fill #8F8F8F";
  #wayland.windowManager.sway.config.output."*".background = "${config.xdg.userDirs.pictures}/FnQswpzX0AIt0uP.jpg fill #8F8F8F";
  wayland.windowManager.sway.config.output."Samsung Electric Company C24FG7x HTNK700265" = {
    position = "0 0"; # load-bearing if crt is in use, idk why
    #adaptive_sync = "on";
    background = "${config.xdg.userDirs.pictures}/3591884.jpg fill #8F8F8F";
  };
  wayland.windowManager.sway.config.output."Samsung Electric Company SAMSUNG Unknown" = {
    position = "1920 0";
  };
  wayland.windowManager.sway.config.output."Samsung Electric Company SAMSUNG" = {
    background = "${config.xdg.userDirs.pictures}/b5ca3eba7925092a3f9f47bf5b1f0c33.png fill #8F8F8F";
  };
  wayland.windowManager.sway.config.output."KIT 41001561224e Unknown" = {
    #mode = "640x480@75Hz";
    position = "0 1080";
    #color_profile = "icc ${./srgb_3.2.icc}";
  };
  wayland.windowManager.sway.config.output."KIT 41001561224e" = {
    background = "${config.xdg.userDirs.pictures}/2af1ea3e5195f698b4dfeb1f32b31afc.png fill #8F8F8F";
  };
  #wayland.windowManager.sway.config.output."Integrated Tech Express Inc HDMI2VGAV121 0x0000FF36" = {
  #  disable = "";
  #  mode = "640x480@75Hz";
  #  position = "1920 600";
  #};
  #wayland.windowManager.sway.config.output."CL@ CM 3316 Unknown" = {
  #  #mode = "640x480@75Hz";
  #  position = "0 1080";
  #};
  #wayland.windowManager.sway.config.output."CL@ CM 3316" = {
  #  background = "#8F8F8F solid_color";
  #};
  wayland.windowManager.sway.config.workspaceOutputAssign = [
    {
      output = "DP-3";
      workspace = "1";
    }
    {
      output = "HDMI-A-1";
      workspace = "4";
    }
    {
      output = "DP-1";
      workspace = "5";
    }
  ];
}
