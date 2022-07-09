{ pkgs, ... }:

let floatingClasses = [
  "CrossCode"
  "Flashplayer"
  "Ledger Live"
  "love"
  "Mojosetup"
  ".scrcpy-wrapped"
];

in {
  wayland.windowManager.sway = {
    enable = true;
    package = null;
    config.bars = [
      {
        mode = "hide";
        position = "bottom";
        statusCommand = "${pkgs.i3status}/bin/i3status";
        extraConfig = ''
          modifier none
        '';
      }
    ];
    config.floating.criteria = [
      { class = builtins.concatStringsSep "|" floatingClasses; }
    ];
    config.focus.followMouse = false;
    config.gaps.inner = 8;
    config.input."4152:4610:SteelSeries_SteelSeries_Apex_Gaming_Keyboard" = {
      xkb_layout = "us";
      xkb_variant = "colemak_dh_iso";
      xkb_options = "caps:escape,compose:menu-altgr";
      xkb_model = "pc105";
    };
    config.input."type:Mouse".accel_profile = "flat";
    config.keybindings."Mod1+Escape" = "mode magic";
    extraConfig = (builtins.readFile ./magicmode.conf) + ''
      include /etc/sway/config.d/*
    '';
  };
}
