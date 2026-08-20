{ config, ... }:

{
  imports = [
    ./packages.nix
    ./i3status.nix
    ./sway.nix
    ./systemd.nix
    # ./terminfo.nix
    ./xdg.nix
  ];

  home.preferXdgDirectories = true;
  home.shell.enableShellIntegration = false;

  home.sessionVariables = {
    CARGO_TARGET_DIR = "${config.xdg.cacheHome}/cargo";
    GRIM_DEFAULT_DIR = "${config.xdg.userDirs.pictures}/grim";
    LESS = "iMR";
    # MOZ_ENABLE_WAYLAND = "0";
    SYSTEMD_LESS = "iMRS";
    SYSTEMD_PAGERSECURE = "1";
    # WINEARCH = "win64";
  };

  home.shellAliases = {
    # cat = "noexec"; # bat
    # find = "noexec"; # fd
    # grep = "noexec"; # rg
    # htop = "noexec"; # btop
    # less = "noexec"; # bat
    # ls = "noexec"; # eza
    # rm = "noexec"; # rip

    cp = "cp --interactive --preserve=timestamps";
    fd = "fd --no-ignore --hidden";
    ls = "ls --classify=auto --color=auto";
    mv = "mv --interactive";
    rg = "rg --no-ignore --hidden --glob='!.git' --smart-case";

    caretify = "sed --null-data --file=${./caretify.sed}";
    nix-locate = "nix run -- github:nix-community/nix-index-database";

    startvnc = ". ${./startvnc.sh}";
    startw = "sway --unsupported-gpu </dev/null >|~/.local/share/sway-o.txt 2>|~/.local/share/sway-e.txt";
  };

  nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.permittedInsecurePackages = [ "dcraw-9.28.0" ];

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-animations = false;
    };
  };

  xresources.properties = {
    # dark theme for Xaw       # applies to:
    "*Background"  = "black";  # *background, *pointerColorBackground
    "*Foreground"  = "gray90"; # *foreground, *pointerColor, *StripChart.highlight
    "*Color"       = "gray90"; # *AsciiSink.cursorColor
    "*BorderColor" = "gray90"; # *borderColor, *Paned.internalBorderColor
    "*ShadowColor" = "gray90"; # *Panner.shadowColor
    "*StripChart.highlight" = "gray50"; # looks better this way

    # make Xaw scrollbars easier to use
    "*Scrollbar.translations" = ''
      #replace \n\
      <Btn1Down>  : StartScroll(Continuous) MoveThumb() NotifyThumb() \n\
      <Btn1Motion>: MoveThumb() NotifyThumb() \n\
      <Btn4Down>  : StartScroll(Backward) \n\
      <Btn5Down>  : StartScroll(Forward) \n\
      <BtnUp>     : NotifyScroll(FullLength) EndScroll()'';
  };

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "erry";
  home.homeDirectory = "/home/erry";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
