{ config, ... }:

{
  imports = [
    ./packages.nix
    ./i3status.nix
    ./i3.nix
    ./sway.nix
    ./systemd.nix
    ./xdg.nix
  ];

  #home.sessionVariables.WINEARCH = "win64";
  home.sessionVariables.GRIM_DEFAULT_DIR = "${config.xdg.userDirs.pictures}/grim";
  #home.sessionVariables.MOZ_ENABLE_WAYLAND = "0";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [ "dcraw-9.28.0" ];

  xresources.properties = {
    #"XTerm.vt100.decTerminalID" = 520;
    "XTerm.vt100.decGraphicsID" = 340;

    "XTerm.vt100.foreground" = "white";
    "XTerm.vt100.background" = "black";
    "XTerm.vt100.boldColors" = false;
    "XTerm.vt100.cursorBar" = true;
    "XTerm.vt100.cursorBlink" = true;

    #"XTerm.vt100.faceName" =
    #  "x:-misc-fixed-medium-r-normal--18-120-100-100-c-90-iso10646-1";
    #"XTerm.vt100.faceNameDoublesize" =
    #  "x:-misc-fixed-medium-r-normal-ja-18-120-100-100-c-180-iso10646-1";
    #"XTerm.vt100.faceName" = "Unifont";
    #"XTerm.vt100.faceSize" = "12";
    "XTerm.vt100.faceName" = "Dina";
    "XTerm.vt100.faceSize" = "10";

    "XTerm.vt100.bellIsUrgent" = true;
    #"XTerm.vt100.visualBell" = true;
    #"XTerm.vt100.visualBellLine" = true;

    "XTerm.vt100.scrollKey" = true;
    "XTerm.vt100.scrollTtyOutput" = false;
    #"XTerm.vt100.allowScrollLock" = true;
    "XTerm.vt100.autoScrollLock" = true;
    "XTerm.vt100.cdXtraScroll" = true;
    "XTerm.buffered" = true;
    "XTerm.vt100.jumpScroll" = true;
    "XTerm.vt100.fastScroll" = false;

    "XTerm.vt100.locale" = true;
    "XTerm.vt100.eightBitInput" = false;
    #"XTerm.vt100.modifyOtherKeys" = 2;
    "XTerm.ttyModes" = "erase ^h";

    "XTerm.vt100.translations" = ''
      #override \n\
         Ctrl~Meta Shift<Key>C  :copy-selection(CLIPBOARD, CUT_BUFFER1) \n\
         Ctrl~Meta Shift<Key>V  :insert-selection(CLIPBOARD, CUT_BUFFER1) \n\
        ~Ctrl~Meta~Shift<Btn2Up>:insert-selection(PRIMARY, CUT_BUFFER0) \n\
        ~Ctrl~Meta Shift<Btn2Up>:insert-selection(CLIPBOARD, CUT_BUFFER1) \n\
                  ~Shift<BtnUp> :select-end(PRIMARY, CUT_BUFFER0) \n\
                   Shift<BtnUp> :select-end(CLIPBOARD, CUT_BUFFER1)
    '';
  };

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "erry";
  home.homeDirectory = "/home/erry";

  #home.shellAliases.cat = "noexec";
  #home.shellAliases.find = "noexec";
  #home.shellAliases.grep = "noexec";
  #home.shellAliases.htop = "noexec";
  #home.shellAliases.less = "noexec";
  #home.shellAliases.ls = "noexec";
  #home.shellAliases.rm = "noexec";
  home.shellAliases.diveo = "mpv --volume=20 --demuxer-max-bytes=10G --demuxer-max-back-bytes=10G --keep-open --vo=gpu-next --hwdec=auto-safe --profile=high-quality --ytdl-format='bestvideo[width<=1920]+bestaudio' --stream-lavf-o=extension_picky=0";
  home.shellAliases.duaio = "mpv --volume=20 --demuxer-max-bytes=10G --demuxer-max-back-bytes=10G --keep-open --no-video --ytdl-format=bestaudio --stream-lavf-o=extension_picky=0";
  home.shellAliases.vile = "mpv --volume=20 --vo=gpu-next --hwdec=auto-safe --profile=high-quality --ytdl-format='bestvideo[width<=1920]+bestaudio' --stream-lavf-o=extension_picky=0";

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
