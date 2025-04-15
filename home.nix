{ config, ... }:

{
  imports = [
    ./packages.nix
    ./i3status.nix
    ./i3.nix
    ./sway.nix
    ./systemd.nix
    ./xdg.nix
    ./xterm.nix
  ];

  #home.sessionVariables.WINEARCH = "win64";
  home.sessionVariables.GRIM_DEFAULT_DIR = "${config.xdg.userDirs.pictures}/grim";
  #home.sessionVariables.MOZ_ENABLE_WAYLAND = "0";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [ "dcraw-9.28.0" ];

  xresources.properties = {
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

  #home.shellAliases.cat = "noexec";
  #home.shellAliases.find = "noexec";
  #home.shellAliases.grep = "noexec";
  #home.shellAliases.htop = "noexec";
  #home.shellAliases.less = "noexec";
  #home.shellAliases.ls = "noexec";
  #home.shellAliases.rm = "noexec";

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
