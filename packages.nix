{ config, lib, pkgs, ... }:

let
  nixBin = name: pkgs.writeScriptBin name (lib.readFile ./${name});

  github-clone = pkgs.writeShellApplication {
    name = "github-clone";
    runtimeInputs = [ pkgs.git ];
    text = lib.readFile ./github-clone.sh;
  };
  irc = pkgs.writeShellApplication {
    name = "irc";
    runtimeInputs = [ pkgs.abduco ];
    text = lib.readFile ./irc.sh;
  };
  noexec = pkgs.writeShellApplication {
    name = "noexec";
    text = lib.readFile ./noexec.sh;
  };
  passmenu-wl = pkgs.writeShellApplication {
    name = "passmenu-wl";
    runtimeInputs = [ pkgs.dmenu-wayland pkgs.pass pkgs.ydotool ];
    text = lib.readFile ./passmenu-wl.bash;
  };
  pscrcpy = pkgs.writeShellApplication {
    name = "pscrcpy";
    runtimeInputs = [ pkgs.scrcpy ];
    text = lib.readFile ./pscrcpy.sh;
  };
  winelegacy = pkgs.writeShellApplication {
    name = "winelegacy";
    #runtimeInputs = [ pkgs.winePackages.waylandFull pkgs.winetricks ];
    runtimeInputs = [ pkgs.winePackages.stagingFull pkgs.winetricks ];
    text = lib.readFile ./wine.sh;
  };
  wine32 = pkgs.writeShellApplication {
    name = "wine32";
    #runtimeInputs = [ pkgs.winePackages.waylandFull pkgs.winetricks ];
    runtimeInputs = [ pkgs.winePackages.stagingFull pkgs.winetricks ];
    text = lib.readFile ./wine.sh;
  };
  wine64 = pkgs.writeShellApplication {
    name = "wine64";
    #runtimeInputs = [ pkgs.wineWowPackages.waylandFull pkgs.winetricks ];
    runtimeInputs = [ pkgs.wineWowPackages.stagingFull pkgs.winetricks ];
    text = lib.readFile ./wine.sh;
  };

  apexctl = pkgs.callPackage ./apexctl { };
  zutty = pkgs.callPackage ./zutty { };

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
    #./bash.nix
    ./emacs.nix
    ./git.nix
    ./ssh.nix
  ];

  programs.btop.enable = true;
  programs.chromium.enable = true;
  programs.feh.enable = true;
  programs.firefox.enable = true;
  #programs.firefox.package = pkgs.firefox-esr-wayland; # windowing broken in general
  #programs.firefox.package = pkgs.firefox-esr; # 60hz target instead of 144hz
  programs.fish.enable = true;
  programs.jq.enable = true;
  programs.jq.colors = {
    null = "1;30";
    false = "0;39";
    true = "0;39";
    numbers = "0;39";
    strings = "0;32";
    arrays = "1;39";
    objects = "1;39";
  };
  programs.lesspipe.enable = true;
  #programs.mako.enable = true;
  programs.mpv.enable = true;
  # TODO mpv
  #programs.nheko.enable = true;
  programs.nix-index.enable = true;
  programs.obs-studio.enable = true;
  programs.password-store.enable = true;
  programs.tmux.enable = true;
  programs.vim.enable = true;
  programs.vim.extraConfig = (lib.readFile ./remap.vim) + ''
    set noesckeys secure
  '';
  programs.yt-dlp.enable = true;

  services.easyeffects.enable = true;

  #services.blueman-applet.enable = true;
  services.fluidsynth.enable = true;
  #services.fluidsynth.soundFont = "${pkgs.soundfont-fluid}/share/soundfonts/FluidR3_GM2-2.sf2";
  services.fluidsynth.soundFont = "/nix/var/nix/profiles/per-user/erry/soundfonts/share/soundfonts/SGM-V2.01.sf2";
  #services.fluidsynth.soundFont = "/nix/var/nix/profiles/per-user/erry/soundfonts/share/soundfonts/titanic.sf2";
  services.fluidsynth.soundService = "pipewire-pulse";
  #services.megasync.enable = true;
  services.mpris-proxy.enable = true;

  home.packages = [
    # sway
      passmenu-wl
        pkgs.ydotool # needed for daemon
      zutty
      pkgs.dmenu-wayland
      pkgs.grim
      pkgs.slurp
      #pkgs.xorg.xrandr

    apexctl
    #ffmpeg-rav1e
    github-clone
    irc
    noexec
    pscrcpy
    #rigsofrods
    winelegacy
    wine32
    wine64

    #pkgs.anbox
    pkgs.appimage-run
    pkgs.bc
    pkgs.bintools
    #pkgs.briar-desktop
    pkgs.chromium-bsu
    pkgs.dcraw
    pkgs.discord
    pkgs.dnsutils
    pkgs.doom-emacs
    #pkgs.dwarf-fortress # broken 2023-02-15
    pkgs.fd
    pkgs.ffmpeg-full
    pkgs.file
    pkgs.gdb
    pkgs.gimp
    pkgs.imagemagick
    pkgs.inetutils
    pkgs.inkscape
    pkgs.kdenlive
    pkgs.killall
    pkgs.ledger-live-desktop
    pkgs.libreoffice-fresh
    #pkgs.linux-manual
    pkgs.lm_sensors
    pkgs.lutris
    pkgs.man-pages
    pkgs.man-pages-posix
    #pkgs.megasync
    #pkgs.microsoft-edge
    pkgs.minetest
    pkgs.moreutils
    pkgs.mumble
    pkgs.nixfmt
    pkgs.nixos-option
    pkgs.nix-output-monitor
    pkgs.nmap
    #pkgs.nodejs
    pkgs.nvtop-amd
    pkgs.openrgb
    pkgs.osu-lazer
    pkgs.p7zip
    pkgs.pagemon
    pkgs.pavucontrol
    pkgs.pcsx2
    pkgs.piper
    #pkgs.polymc
    pkgs.poppler_utils
    pkgs.pv
    pkgs.qrencode
    pkgs.qpwgraph
    pkgs.qtox
    pkgs.ripcord
    pkgs.ripgrep
    pkgs.rm-improved
    pkgs.scanmem
    pkgs.scrot
    pkgs.shellcheck
    pkgs.socat
    pkgs.steamcmd
    pkgs.superTuxKart
    pkgs.syncplay
    pkgs.texstudio
    pkgs.turbovnc
    pkgs.unzip
    pkgs.usbutils
    pkgs.vgmstream
    pkgs.wget
    #pkgs.winePackages.waylandFull
    #pkgs.wineWowPackages.waylandFull
    #pkgs.winetricks
    pkgs.xonotic
    pkgs.zip
    (pkgs.texlive.combine {
      inherit (pkgs.texlive)
        scheme-medium cbfonts cleveref gfsartemisia lipsum srcltx titlesec was;
    })
  ];
}
