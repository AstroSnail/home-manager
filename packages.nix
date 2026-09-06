{ config, lib, pkgs, ... }:

let
  #nixBin = name: pkgs.writeScriptBin name (lib.readFile ./${name});

in {
  imports = [
    ./bash.nix
    ./editres.nix
    ./emacs.nix
    ./git.nix
    #./gnome-terminal.nix
    ./kitty.nix
    ./mpv.nix
    ./readline.nix
    ./ssh.nix
    ./updates.nix
    ./urxvt.nix
    ./vim.nix
    # NOTE: after re-enabling vscode, also add direnv and lua-language-server to packages
    # ./vscode.nix
    ./vscodium.nix
    ./xterm.nix
    ./zutty.nix
  ];

  nixpkgs.overlays = [
    (final: prev: {

      apexctl = final.callPackage (final.fetchFromGitHub {
        owner = "AstroSnail";
        repo = "apexctl";
        rev = "b1e894cd7d7aa067f5dfa492e88c99708163c7d1";
        hash = "sha256-v23F+XjCMtaXxe2OHmHzlRvtmSdB8yS2Fh3LPo8Hp2s=";
      }) { };

      # direnv = prev.direnv.overrideAttrs (oldattrs: {
      #   installPhase = oldattrs.installPhase + ''
      #     runHook postInstall
      #   '';
      #   postInstall = ''
      #     rm $out/share/fish/vendor_conf.d/direnv.fish
      #   '';
      # });

      # ideally this would provide a "withFortunes" or something to add extra
      # fortunes to the package
      fortune = prev.fortune.overrideAttrs (finalAttrs: prevAttrs: {
        postInstall = (prevAttrs.postInstall or "") + ''
          vex=$out/share/games/fortunes/vex
          cp ${./vex} "$vex"
          "$out"/bin/strfile -x "$vex"
          ln -s vex "$vex".u8
        '';
      });

      # noexec = final.writeShellApplication {
      #   name = "noexec";
      #   text = lib.readFile ./noexec.sh;
      # };

      openrgb = prev.openrgb.overrideAttrs (finalAttrs: prevAttrs: {
        patches = (prevAttrs.patches or []) ++ [ ./openrgb-oldapex.patch ];
      });

      passmenu-patient = final.writeShellApplication {
        name = "passmenu-patient";
        #runtimeInputs = [ final.dmenu-wayland final.pass final.ydotool ];
        runtimeInputs = [ final.dmenu final.pass final.xdotool final.ydotool ];
        text = lib.readFile ./passmenu-patient.bash;
      };

      # broken 2025-03-11
      # vlc = prev.vlc.overrideAttrs (oldattrs: {
      #   buildInputs = oldattrs.buildInputs ++ [ final.projectm ];
      # });

      vte = prev.vte.overrideAttrs (finalAttrs: prevAttrs: {
        patches = (prevAttrs.patches or []) ++ [ ./vte-term.patch ];
      });

      # winelegacy = final.writeShellApplication {
      #   name = "winelegacy";
      #   # runtimeInputs = [ final.winePackages.waylandFull final.winetricks ];
      #   # runtimeInputs = [ final.winePackages.stagingFull final.winetricks ];
      #   runtimeInputs = [ final.winePackages.full final.winetricks ];
      #   text = lib.readFile ./wine.sh;
      # };

      # wine32 = final.writeShellApplication {
      #   name = "wine32";
      #   # runtimeInputs = [ final.winePackages.waylandFull final.winetricks ];
      #   # runtimeInputs = [ final.winePackages.stagingFull final.winetricks ];
      #   runtimeInputs = [ final.winePackages.full final.winetricks ];
      #   text = lib.readFile ./wine.sh;
      # };

      # wine64 = final.writeShellApplication {
      #   name = "wine64";
      #   # runtimeInputs = [ final.wineWow64Packages.waylandFull final.winetricks ];
      #   # runtimeInputs = [ final.wineWow64Packages.stagingFull final.winetricks ];
      #   runtimeInputs = [ final.wineWow64Packages.full final.winetricks ];
      #   text = lib.readFile ./wine.sh;
      # };
    })
  ];

  # programs.btop.enable = true;
  programs.chromium.enable = true;
  programs.direnv.enable = true;
  # programs.direnv.enableBashIntegration = false;
  #programs.direnv.enableFishIntegration = false;
  #programs.direnv.nix-direnv.enable = true;
  # programs.element-desktop.enable = true;
  #programs.eza.enable = true;
  #programs.eza.enableBashIntegration = false;
  #programs.eza.enableFishIntegration = false;
  programs.fd.enable = true;
  # programs.feh.enable = true;
  programs.firefox.enable = true;
  programs.firefox.package = pkgs.firefox-esr;
  # TODO: migrate to ${config.xdg.configHome}/mozilla/firefox
  programs.firefox.configPath = "${config.home.homeDirectory}/.mozilla/firefox";
  # programs.fish.enable = true;
  #programs.htop.enable = true; # TODO: port config to here
  programs.jq.enable = true;
  #programs.jq.colors = {
  #  null = "1;30";
  #  false = "0;39";
  #  true = "0;39";
  #  numbers = "0;39";
  #  strings = "0;32";
  #  arrays = "1;39";
  #  objects = "1;39";
  #};
  programs.less.enable = true;
  #programs.lesspipe.enable = true;
  #programs.nheko.enable = true;
  # programs.nix-index.enable = true;
  # programs.nix-index.enableBashIntegration = false;
  # programs.nix-index.enableFishIntegration = false;
  programs.obs-studio.enable = true;
  programs.obs-studio.plugins = [
    pkgs.obs-studio-plugins.obs-livesplit-one
    pkgs.obs-studio-plugins.obs-pipewire-audio-capture
    pkgs.obs-studio-plugins.wlrobs
  ];
  programs.password-store.enable = true; # see also services.pass-secret-service
  programs.password-store.settings.PASSWORD_STORE_DIR = "${config.xdg.dataHome}/password-store";
  programs.ripgrep.enable = true;
  programs.ripgrep.arguments = [ "--glob=!.git" ];
  #programs.texlive.enable = true; # broken 2025-07-17
  programs.texlive.extraPackages = tpkgs: {
    inherit (tpkgs)
      scheme-medium cbfonts cleveref gfsartemisia lipsum listingsutf8 srcltx titlesec was
      pgfplots prooftrees svn-prov forest standalone ucs;
  };
  # programs.thunderbird.enable = true;
  # programs.timidity.enable = true;
  # programs.timidity.extraConfig = ''
  #   soundfont /nix/var/nix/profiles/per-user/erry/soundfonts/share/soundfonts/SGM-V2.01.sf2
  #   #soundfont /nix/var/nix/profiles/per-user/erry/soundfonts/share/soundfonts/FluidR3_GM.sf2
  #   #soundfont /nix/var/nix/profiles/per-user/erry/soundfonts/share/soundfonts/FluidR3_GS.sf2
  #   #soundfont ${pkgs.soundfont-fluid}/share/soundfonts/FluidR3_GM2-2.sf2
  #   #soundfont ${pkgs.soundfont-arachno}/share/soundfonts/arachno.sf2
  #   #soundfont ${pkgs.soundfont-ydp-grand}/share/soundfonts/YDP-GrandPiano.sf2
  #   #soundfont ${pkgs.soundfont-generaluser-gs}/share/soundfonts/GeneralUser-GS.sf2
  # '';
  #programs.tmux.enable = true;
  programs.yt-dlp.enable = true;

  #services.blueman-applet.enable = true;
  #services.dunst.enable = true;
  #services.dunst.settings.global.dmenu = "${pkgs.dmenu}/bin/dmenu -p dunst";
  #services.easyeffects.enable = true;
  #services.fluidsynth.enable = true;
  #services.fluidsynth.soundFont = "${pkgs.soundfont-fluid}/share/soundfonts/FluidR3_GM2-2.sf2";
  # services.fluidsynth.soundFont = "/nix/var/nix/profiles/per-user/erry/soundfonts/share/soundfonts/SGM-V2.01.sf2";
  #services.fluidsynth.soundFont = "/nix/var/nix/profiles/per-user/erry/soundfonts/share/soundfonts/titanic.sf2";
  # services.fluidsynth.soundService = "pipewire-pulse";
  services.gpg-agent.enable = true;
  services.gpg-agent.pinentry.package = pkgs.pinentry-qt;
  services.gpg-agent.enableBashIntegration = true;
  services.mako.enable = true;
  #services.megasync.enable = true;
  services.mpris-proxy.enable = true;
  services.pass-secret-service.enable = true; # see also programs.password-store
  services.protonmail-bridge.enable = true;
  services.protonmail-bridge.package = pkgs.protonmail-bridge-gui;
  services.protonmail-bridge.extraPackages = [ pkgs.pass ];
  systemd.user.services.protonmail-bridge.Install.WantedBy = lib.mkForce [ ];
  services.wayvnc.enable = true;
  # TODO: unix socket
  services.wayvnc.settings.address = "::1";
  services.wayvnc.settings.port = 5900;
  services.wayvnc.settings.xkb_model = "pc105";
  services.wayvnc.settings.xkb_layout = "us,pt";
  services.wayvnc.settings.xkb_variant = "";
  # services.wayvnc.settings.xkb_options = "caps:escape,compose:menu";
  services.wayvnc.settings.xkb_options = "compose:menu,grp:sclk_toggle";

  home.packages = [
    pkgs._7zz
    #pkgs.anbox
    pkgs.android-tools
    pkgs.apexctl
    # pkgs.appimage-run
    #pkgs.ares # broken 2025-06-20
    pkgs.ascii
    # pkgs.bat
    pkgs.bc
    # pkgs.bchunk
    pkgs.bintools
    #pkgs.blender
    #pkgs.briar-desktop
    #pkgs.chessx
    #pkgs.chromium-bsu
    #pkgs.croc
    #pkgs.dcraw
    #pkgs.direnv
    #pkgs.discord
    pkgs.dmenu
    #pkgs.dmenu-wayland
    #pkgs.dnsutils
    #pkgs.doom-emacs
    #pkgs.dos2unix
    #pkgs.dwarf-fortress # broken 2023-02-15
    #pkgs.espeak
    #pkgs.evince
    pkgs.ffmpeg-full
    pkgs.file
    pkgs.fortune
    #pkgs.gamescope
    #pkgs.gdb
    #pkgs.gdmap # broken 2024-12-28
    #pkgs.ghostscript
    # pkgs.gimp
    #pkgs.gparted
    pkgs.grim
    #pkgs.gzdoom
    pkgs.htop
    # pkgs.imagemagick
    #pkgs.inetutils
    #pkgs.inkscape
    #pkgs.iotop
    # pkgs.irssi
    # pkgs.jre
    #pkgs.kdenlive # replaced with kdepackages.kdenlive 2025-02-25
    #pkgs.killall
    #pkgs.krita
    #pkgs.ledger-live-desktop
    pkgs.libreoffice
    #pkgs.libva-utils
    #pkgs.linux-manual
    #pkgs.lm_sensors
    #pkgs.ltrace
    # (pkgs.lua5_3.withPackages (ps: [ ps.lpeg ]))
    #(pkgs.luajit_2_1.withPackages (ps: [ ps.lpeg ]))
    # pkgs.lua-language-server
    #pkgs.lutris
    pkgs.lxterminal
    pkgs.man-pages
    pkgs.man-pages-posix
    #pkgs.megasync
    #pkgs.melonDS
    #pkgs.microsoft-edge
    #pkgs.minetest # broken by bisect
    pkgs.moreutils
    #pkgs.mumble # broken 2025-03-16
    # pkgs.ncdu
    #pkgs.nixfmt
    # pkgs.nixos-option
    # pkgs.nix-output-monitor
    #pkgs.nixpkgs-fmt
    #pkgs.nmap
    #pkgs.nodejs
    # pkgs.noexec
    #pkgs.nvtopPackages.amd
    # pkgs.openrgb # broken 2026-01-12
    #pkgs.openssl
    #pkgs.osu-lazer
    # pkgs.p7zip
    #pkgs.pagemon
    pkgs.passmenu-patient
    pkgs.pavucontrol
    #pkgs.pciutils
    # pkgs.pcsx2 # broken 2026-08-13
    #pkgs.pcsxr
    #pkgs.piper
    #pkgs.polymc
    #pkgs.poppler_utils
    # pkgs.prismlauncher
    #pkgs.protontricks
    # pkgs.pv
    # (pkgs.python3.withPackages (ps: [ ps.matplotlib ps.more-itertools ps.numpy ps.sympy ps.pycurl ps.certifi ]))
    # pkgs.python3
    #pkgs.qemu_full
    #pkgs.qrencode
    #pkgs.qpwgraph
    #pkgs.qtox
    #pkgs.ripcord
    pkgs.rm-improved
    # pkgs.sameboy
    #pkgs.scanmem
    #pkgs.scrot
    pkgs.signal-desktop
    #pkgs.shellcheck
    pkgs.slurp
    #pkgs.socat
    #pkgs.speechd
    #pkgs.steamcmd
    #pkgs.strongswan
    #pkgs.superTuxKart
    # pkgs.syncplay
    pkgs.texstudio
    pkgs.thunderbird
    #pkgs.turbovnc
    # pkgs.unrar
    #pkgs.unzip
    #pkgs.usbutils
    #pkgs.vdpauinfo
    # pkgs.vesktop # broken 2026-01-03
    #pkgs.vgmstream
    #pkgs.vlc
    #pkgs.vttest
    #pkgs.wget
    # pkgs.winelegacy
    # pkgs.wine32
    # pkgs.wine64
    #pkgs.winePackages.waylandFull
    #pkgs.wineWow64Packages.waylandFull
    #pkgs.winetricks
    pkgs.wl-clipboard
    pkgs.xdotool
    #pkgs.xonotic
    #pkgs.xorg.xkill
    #pkgs.ydotool
    #pkgs.zip
    #pkgs.zopfli
  ];
}
