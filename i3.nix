{ config, lib, pkgs, ... }:

let
  floatingClasses = [
    "\\.exe$"
    "^\\.blueman-manager-wrapped$"
    #"^Chromium-browser$"
    "^Dwarf_Fortress$"
    #"^easyeffects$"
    "^eidguiV2$"
    "^ffplay$"
    "^Flashplayer$"
    "^Ledger Live$"
    "^love$"
    "^MEGAsync$"
    "^Minecraft\\*? "
    "^Minetest$"
    "^Mojosetup$"
    "^NanoBoyAdvance$"
    "^net\\.querz\\.mcaselector\\.ui\\.Window$"
    "^org-prismlauncher-EntryPoint$"
    #"^Pavucontrol$"
    #"^Pcsx2$"
    "^Qemu-system-x86_64$"
    "^\\.sameboy-wrapped$"
    #"^\\.scrcpy-wrapped$"
    #"^Steam$"
    #"^steam$"
    "^steam_app_11020$"
    "^steam_proton$"
    "^Tor Browser$"
    "^Terraria\\.bin\\.x86_64$"
  ];
  #floatingTitles = [ "Rigs of Rods" ];
  #fonts = {
  #  #names = [ "Hack" ];
  #  size = 10.0;
  #};

in {
  xsession.windowManager.i3.enable = true;
  xsession.windowManager.i3.package = pkgs.i3-gaps;
  xsession.windowManager.i3.config.bars = [{
    mode = "hide";
    #fonts = fonts;
    position = "bottom";
    statusCommand = "${pkgs.i3status}/bin/i3status";
    trayOutput = "primary";
    extraConfig = ''
      font -misc-fixed-medium-r-normal--18-120-100-100-c-90-iso10646-1
      modifier none
    '';
  }];
  xsession.windowManager.i3.config.floating.criteria =
    [{ class = lib.concatStringsSep "|" floatingClasses; }];
  xsession.windowManager.i3.config.floating.modifier = "Mod4";
  xsession.windowManager.i3.config.floating.titlebar = true;
  xsession.windowManager.i3.config.focus.followMouse = false;
  #xsession.windowManager.i3.config.fonts = fonts;
  xsession.windowManager.i3.config.gaps.inner = 8;
  xsession.windowManager.i3.config.keybindings."Mod1+Escape" = "mode magic";
  xsession.windowManager.i3.config.window.titlebar = true;
  xsession.windowManager.i3.config.workspaceLayout = "tabbed";
  xsession.windowManager.i3.extraConfig = (lib.readFile ./magicmode.conf) + ''
    font -misc-fixed-medium-r-normal--18-120-100-100-c-90-iso10646-1
    for_window [all] title_window_icon yes
    exec --no-startup-id setxkbmap
    exec --no-startup-id feh --image-bg '#8F8F8F' --no-fehbg --bg-fill ${config.xdg.userDirs.pictures}/FnQswpzX0AIt0uP.jpg --bg-fill ${config.xdg.userDirs.pictures}/upload_528af259f560c1e462768d8662448ebf.png
    #exec --no-startup-id blueman-applet
  '';
}
