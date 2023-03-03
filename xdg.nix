{ config, ... }:

{
  xdg.enable = true;
  xdg.mime.enable = true;
  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/http" = [ "firefox.desktop" ];
    "x-scheme-handler/https" = [ "firefox.desktop" ];
  };
  xdg.userDirs.enable = true;
  xdg.userDirs.createDirectories = true;

  # fixing garbage a bit maybe?
  xdg.cacheHome = "${config.home.homeDirectory}/.cache";
  xdg.configHome = "${config.home.homeDirectory}/.config";
  xdg.dataHome = "${config.home.homeDirectory}/.local/share";
  xdg.stateHome = "${config.home.homeDirectory}/.local/state";
  xdg.userDirs.desktop = "${config.home.homeDirectory}/Desktop";
  xdg.userDirs.documents = "${config.home.homeDirectory}/Documents";
  xdg.userDirs.download = "${config.home.homeDirectory}/Downloads";
  xdg.userDirs.music = "${config.home.homeDirectory}/Music";
  xdg.userDirs.pictures = "${config.home.homeDirectory}/Pictures";
  xdg.userDirs.publicShare = "${config.home.homeDirectory}/Public";
  xdg.userDirs.templates = "${config.home.homeDirectory}/Templates";
  xdg.userDirs.videos = "${config.home.homeDirectory}/Videos";
}
