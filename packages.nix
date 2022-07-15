{ config, pkgs, ... }:

let
  nixBin = name: pkgs.writeScriptBin name (builtins.readFile ./${name});

  doom = nixBin "doom";
  github-clone = nixBin "github-clone";
  irc = nixBin "irc";
  passmenu-wl = nixBin "passmenu-wl";
  pscrcpy = nixBin "pscrcpy";
  # TODO wrap these with their deps

  apexctl = pkgs.callPackage ./apexctl { };

  ffmpeg-rav1e = pkgs.ffmpeg-full.override {
    rav1e = pkgs.rav1e;
  };

  #rigsofrods = pkgs.rigsofrods.overrideAttrs (_: rec {
  #  version = "2022.04";
  #  src = pkgs.fetchFromGitHub {
  #    owner = "RigsOfRods";
  #    repo = "rigs-of-rods";
  #    rev = version;
  #    sha256 = "sha256-QExh7ujPvKL9UOByNKvhKgmhpmAOt+OsoZeH50Brww0=";
  #  };
  #});
  rigsofrods = pkgs.rigsofrods;
  # TODO figure out how to compile

in {
  imports = [
    ./emacs.nix
    ./git.nix
    ./ssh.nix
  ];

  programs.bash.enable = true;
  programs.bash.historyFile = "${config.xdg.stateHome}/bash_history";
  programs.chromium.enable = true;
  programs.feh.enable = true;
  programs.firefox.enable = true;
  #programs.firefox.package = pkgs.firefox-wayland;
  programs.jq.enable = true;
  programs.lesspipe.enable = true;
  programs.mpv.enable = true;
  # TODO mpv
  programs.nix-index.enable = true;
  programs.obs-studio.enable = true;
  programs.password-store.enable = true;
  programs.vim.enable = true;
  programs.vim.extraConfig = (builtins.readFile ./remap.vim) + ''
    set noesckeys secure
  '';

  #services.blueman-applet.enable = true;
  services.mpris-proxy.enable = true;

  home.packages = [
    # sway
      pkgs.grim
      pkgs.slurp
      pkgs.xfce.xfce4-terminal

    apexctl
    doom
    #ffmpeg-rav1e
    github-clone
    irc
    passmenu-wl # also sway
      pkgs.dmenu-wayland
      pkgs.ydotool
    pscrcpy
      pkgs.scrcpy
    rigsofrods

    pkgs.appimage-run
    pkgs.bc
    pkgs.dcraw
    pkgs.discord
    pkgs.dnsutils
    pkgs.ffmpeg-full
    pkgs.file
    pkgs.gimp
    pkgs.imagemagick
    pkgs.inetutils
    pkgs.killall
    pkgs.ledger-live-desktop
    pkgs.libreoffice-fresh
    pkgs.linux-manual
    pkgs.lm_sensors
    pkgs.man-pages
    pkgs.man-pages-posix
    pkgs.moreutils
    pkgs.mumble
    #pkgs.nheko
    pkgs.nixfmt
    pkgs.nixos-option
    pkgs.nmap
    #pkgs.nodejs
    pkgs.openrgb
    pkgs.p7zip
    pkgs.pavucontrol
    #pkgs.ripcord
    pkgs.superTuxKart
    pkgs.syncplay
    pkgs.texstudio
    pkgs.usbutils
    pkgs.wineWowPackages.waylandFull
    pkgs.winetricks
    pkgs.yt-dlp
    (pkgs.texlive.combine {
      inherit (pkgs.texlive)
        scheme-medium cbfonts cleveref gfsartemisia lipsum srcltx titlesec was;
    })
  ];
}
