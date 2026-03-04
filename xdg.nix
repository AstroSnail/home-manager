{ config, ... }:

{
  xdg.enable = true;
  xdg.mime.enable = true;
  xdg.mimeApps.enable = true;
  xdg.mimeApps.associations.added = {
    "x-scheme-handler/http" = [ "firefox.desktop" ];
    "x-scheme-handler/https" = [ "firefox.desktop" ];
    "text/html" = [ "firefox.desktop" ];
    "x-scheme-handler/chrome" = [ "firefox.desktop" ];

    "x-scheme-handler/mailto" = [ "thunderbird.desktop" ];
    "x-scheme-handler/mid" = [ "thunderbird.desktop" ];
    "x-scheme-handler/news" = [ "thunderbird.desktop" ];
    "x-scheme-handler/snews" = [ "thunderbird.desktop" ];
    "x-scheme-handler/nntp" = [ "thunderbird.desktop" ];
    "x-scheme-handler/feed" = [ "thunderbird.desktop" ];
    "application/rss+xml" = [ "thunderbird.desktop" ];
    "application/x-extension-rss" = [ "thunderbird.desktop" ];
    "x-scheme-handler/webcal" = [ "thunderbird.desktop" ];
    "x-scheme-handler/webcals" = [ "thunderbird.desktop" ];
  };
  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/http" = [ "firefox.desktop" ];
    "x-scheme-handler/https" = [ "firefox.desktop" ];
    "x-scheme-handler/chrome" = [ "firefox.desktop" ];
    "text/html" = [ "firefox.desktop" ];
    "application/x-extension-htm" = [ "firefox.desktop" ];
    "application/x-extension-html" = [ "firefox.desktop" ];
    "application/x-extension-shtml" = [ "firefox.desktop" ];
    "application/xhtml+xml" = [ "firefox.desktop" ];
    "application/x-extension-xhtml" = [ "firefox.desktop" ];
    "application/x-extension-xht" = [ "firefox.desktop" ];

    "x-scheme-handler/about" = [ "chromium-browser.desktop" ];
    "x-scheme-handler/unknown" = [ "chromium-browser.desktop" ];

    "x-scheme-handler/mailto" = [ "thunderbird.desktop" ];
    "message/rfc822" = [ "thunderbird.desktop" ];
    "x-scheme-handler/mid" = [ "thunderbird.desktop" ];
    "x-scheme-handler/news" = [ "thunderbird.desktop" ];
    "x-scheme-handler/snews" = [ "thunderbird.desktop" ];
    "x-scheme-handler/nntp" = [ "thunderbird.desktop" ];
    "x-scheme-handler/feed" = [ "thunderbird.desktop" ];
    "application/rss+xml" = [ "thunderbird.desktop" ];
    "application/x-extension-rss" = [ "thunderbird.desktop" ];
    "x-scheme-handler/webcal" = [ "thunderbird.desktop" ];
    "text/calendar" = [ "thunderbird.desktop" ];
    "application/x-extension-ics" = [ "thunderbird.desktop" ];
    "x-scheme-handler/webcals" = [ "thunderbird.desktop" ];
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
