{ config, ... }:

{
  xdg.enable = true;
  xdg.mime.enable = true;
  xdg.mimeApps.enable = true;
  xdg.mimeApps.associations.added = {
    "x-scheme-handler/http" = [ "firefox-esr.desktop" ];
    "x-scheme-handler/https" = [ "firefox-esr.desktop" ];
    "x-scheme-handler/chrome" = [ "firefox-esr.desktop" ];
    "text/html" = [ "firefox-esr.desktop" ];
    "application/x-extension-htm" = [ "firefox-esr.desktop" ];
    "application/x-extension-html" = [ "firefox-esr.desktop" ];
    "application/x-extension-shtml" = [ "firefox-esr.desktop" ];
    "application/xhtml+xml" = [ "firefox-esr.desktop" ];
    "application/x-extension-xhtml" = [ "firefox-esr.desktop" ];
    "application/x-extension-xht" = [ "firefox-esr.desktop" ];
  };
  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/http" = [ "firefox-esr.desktop" ];
    "x-scheme-handler/https" = [ "firefox-esr.desktop" ];
    "x-scheme-handler/chrome" = [ "firefox-esr.desktop" ];
    "text/html" = [ "firefox-esr.desktop" ];
    "application/x-extension-htm" = [ "firefox-esr.desktop" ];
    "application/x-extension-html" = [ "firefox-esr.desktop" ];
    "application/x-extension-shtml" = [ "firefox-esr.desktop" ];
    "application/xhtml+xml" = [ "firefox-esr.desktop" ];
    "application/x-extension-xhtml" = [ "firefox-esr.desktop" ];
    "application/x-extension-xht" = [ "firefox-esr.desktop" ];
  };
  xdg.userDirs.enable = true;
  xdg.userDirs.createDirectories = true;

  # replace tildes with absolute home dir
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
