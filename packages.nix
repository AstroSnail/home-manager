{ config, lib, pkgs, ... }:

let
  #nixBin = name: pkgs.writeScriptBin name (lib.readFile ./${name});

  github-clone = pkgs.writeShellApplication {
    name = "github-clone";
    runtimeInputs = [ pkgs.git ];
    text = lib.readFile ./github-clone.sh;
  };
  noexec = pkgs.writeShellApplication {
    name = "noexec";
    text = lib.readFile ./noexec.sh;
  };
  passmenu-patient = pkgs.writeShellApplication {
    name = "passmenu-patient";
    #runtimeInputs = [ pkgs.dmenu-wayland pkgs.pass pkgs.ydotool ];
    runtimeInputs = [ pkgs.dmenu pkgs.pass pkgs.xdotool pkgs.ydotool ];
    text = lib.readFile ./passmenu-patient.bash;
  };
  pscrcpy = pkgs.writeShellApplication {
    name = "pscrcpy";
    runtimeInputs = [ pkgs.scrcpy ];
    text = lib.readFile ./pscrcpy.sh;
  };
  #slurpgrim = pkgs.writeShellApplication {
  #  name = "slurpgrim";
  #  runtimeInputs = [
  #    pkgs.grim
  #    pkgs.slurp
  #  ];
  #  text = lib.readFile ./slurpgrim.sh;
  #};
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
  #zutty = pkgs.callPackage ./zutty { };

  #ffmpeg-rav1e = pkgs.ffmpeg-full.override {
  #  rav1e = pkgs.rav1e;
  #};

  #rigsofrods = pkgs.rigsofrods.overrideAttrs (_: rec {
  #  version = "2022.04";
  #  src = pkgs.fetchFromGitHub {
  #    owner = "RigsOfRods";
  #    repo = "rigs-of-rods";
  #    rev = version;
  #    sha256 = "sha256-QExh7ujPvKL9UOByNKvhKgmhpmAOt+OsoZeH50Brww0=";
  #  };
  #});
  #rigsofrods = pkgs.rigsofrods;
  # TODO figure out how to compile

in {
  imports = [
    ./bash.nix
    ./emacs.nix
    ./git.nix
    ./ssh.nix
  ];

  nixpkgs.overlays = [
    (final: prev: {
      mpv-unwrapped =
        prev.mpv-unwrapped.override { ffmpeg = final.ffmpeg-full; };
    })
    #(final: prev: {
    #  yt-dlp = prev.yt-dlp.overrideAttrs (finalAttrs: prevAttrs: {
    #    version = "git";
    #    src = final.fetchFromGitHub {
    #      owner = "yt-dlp";
    #      repo = "yt-dlp";
    #      rev = "7237c8dca0590aa7438ade93f927df88c9381ec7";
    #      sha256 = "sha256-wCj2kFkJLGbVIQ5obvA0Q++bSHbwFD/BvdGXsNGR6Zw=";
    #    };
    #  });
    #})
    #(final: prev: {
    #  mpv = prev.mpv.override {
    #    extraMakeWrapperArgs =
    #      [ "--prefix" "PATH" ":" (lib.makeBinPath [ pkgs.xclip ]) ];
    #  };
    #})
    #(final: prev: {
    #  direnv = prev.direnv.overrideAttrs (oldattrs: {
    #    installPhase = oldattrs.installPhase + ''
    #      runHook postInstall
    #    '';
    #    postInstall = ''
    #      rm $out/share/fish/vendor_conf.d/direnv.fish
    #    '';
    #  });
    #})
    # broken 2025-03-11
    #(final: prev: {
    #  vlc = prev.vlc.overrideAttrs (oldattrs: {
    #    buildInputs = oldattrs.buildInputs ++ [ pkgs.projectm ];
    #  });
    #})
    #(final: prev: {
    #  readline = prev.readline.overrideAttrs (oldattrs: {
    #    patches = oldattrs.patches ++ [ ./readline.patch ];
    #  });
    #})
  ];

  programs.btop.enable = true;
  programs.chromium.enable = true;
  #programs.direnv.enable = true;
  #programs.direnv.enableFishIntegration = false;
  #programs.direnv.nix-direnv.enable = true;
  #programs.eza.enable = true;
  #programs.eza.enableBashIntegration = false;
  #programs.eza.enableFishIntegration = false;
  programs.fd.enable = true;
  programs.feh.enable = true;
  programs.firefox.enable = true;
  programs.firefox.package = pkgs.firefox-esr;
  programs.fish.enable = true;
  #programs.irssi.enable = true;
  #programs.irssi.networks.tilde-chat.nick = "crcl";
  #programs.irssi.networks.tilde-chat.channels."#tilde.pt".autoJoin = false;
  #programs.irssi.networks.tilde-chat.server.address = "eu.tilde.chat";
  #programs.irssi.networks.tilde-chat.server.port = 6697;
  #programs.irssi.networks.tilde-chat.server.autoConnect = false;
  #programs.irssi.networks.tilde-chat.server.ssl.enable = true;
  #programs.irssi.networks.tilde-chat.server.ssl.verify = true;
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
  #programs.lesspipe.enable = true;
  programs.mpv.enable = true;
  # TODO mpv
  #programs.nheko.enable = true;
  programs.nix-index.enable = true;
  programs.nix-index.enableBashIntegration = false;
  programs.nix-index.enableFishIntegration = false;
  programs.obs-studio.enable = true;
  programs.obs-studio.plugins = [
    pkgs.obs-studio-plugins.obs-livesplit-one
    pkgs.obs-studio-plugins.obs-pipewire-audio-capture
    pkgs.obs-studio-plugins.wlrobs
  ];
  programs.password-store.enable = true;
  programs.ripgrep.enable = true;
  programs.texlive.enable = true;
  programs.texlive.extraPackages = tpkgs: {
    inherit (tpkgs)
      scheme-medium cbfonts cleveref gfsartemisia lipsum listingsutf8 srcltx titlesec was
      pgfplots prooftrees svn-prov forest standalone ucs;
  };
  programs.timidity.enable = true;
  programs.timidity.extraConfig = ''
    soundfont /nix/var/nix/profiles/per-user/erry/soundfonts/share/soundfonts/SGM-V2.01.sf2
    #soundfont /nix/var/nix/profiles/per-user/erry/soundfonts/share/soundfonts/FluidR3_GM.sf2
    #soundfont /nix/var/nix/profiles/per-user/erry/soundfonts/share/soundfonts/FluidR3_GS.sf2
    #soundfont ${pkgs.soundfont-fluid}/share/soundfonts/FluidR3_GM2-2.sf2
    #soundfont ${pkgs.soundfont-arachno}/share/soundfonts/arachno.sf2
    #soundfont ${pkgs.soundfont-ydp-grand}/share/soundfonts/YDP-GrandPiano.sf2
    #soundfont ${pkgs.soundfont-generaluser}/share/soundfonts/GeneralUser-GS.sf2
  '';
  #programs.tmux.enable = true;
  programs.vim.enable = true;
  programs.vim.plugins = lib.mkForce [
    (pkgs.vimUtils.buildVimPlugin {
      name = "vim-erry";
      src = ./vim-erry;
    })
    pkgs.vimPlugins.easymotion
  ];
  programs.vim.extraConfig = ''
    runtime defaults.vim
    autocmd! vimHints

    set formatoptions+=j selection=exclusive

    " make scrolling reachable from usual navigation keys
    " for some reason <C-S-n/p> don't work?
    " TODO: investigate
    noremap <C-j> <C-e>
    "noremap <C-S-j> <C-S-n>
    noremap <C-S-j> <C-d>
    noremap <C-k> <C-y>
    "noremap <C-S-k> <C-S-p>
    noremap <C-S-k> <C-u>

    " EasyMotion
    noremap gs <Plug>(easymotion-prefix)
  '';
  #programs.vscode.enable = true; # broken 2025-02-18
  programs.vscode.mutableExtensionsDir = false;
  programs.vscode.profiles.default.extensions = [
    pkgs.vscode-extensions.ms-vsliveshare.vsliveshare
    pkgs.vscode-extensions.sumneko.lua
    pkgs.vscode-extensions.james-yu.latex-workshop
    pkgs.vscode-extensions.ms-vscode.cpptools
    pkgs.vscode-extensions.ms-vscode.hexeditor
    pkgs.vscode-extensions.ms-vscode.cmake-tools
    pkgs.vscode-extensions.twxs.cmake
    pkgs.vscode-extensions.rust-lang.rust-analyzer
    pkgs.vscode-extensions.mkhl.direnv
    pkgs.vscode-extensions.editorconfig.editorconfig
    pkgs.vscode-extensions.eamodio.gitlens
    pkgs.vscode-extensions.jnoortheen.nix-ide
    pkgs.vscode-extensions.continue.continue
  ] ++ (pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "cursorless";
      publisher = "pokey";
      version = "0.26.495";
      sha256 = "sha256-VR1LMA86WRszU/66eP+aH7iAm4yxsMHhMPCIWFtYJfc=";
    }
    {
      name = "parse-tree";
      publisher = "pokey";
      version = "0.28.2";
      sha256 = "sha256-pqf3/GaKkrBBHPTGcfPHo3p4Ja5a/YrQ7dSOjP1Lc2o=";
    }
    {
      name = "vscode-capnp";
      publisher = "xmonader";
      version = "1.0.0";
      sha256 = "sha256-zIkiDaWWay+6U4aA4ioTy/9MUk9mD+NLHX7kjQ2FWnw=";
    }
    {
      name = "second-local-lua-debugger-vscode";
      publisher = "ismoh-games";
      version = "0.3.8";
      sha256 = "sha256-xuOIBBnVWNREAAkAXkdSEsdqM49g+ngmNKtgJWrATNA=";
    }
  ]);
  programs.yt-dlp.enable = true;

  #services.dunst.enable = true;
  #services.dunst.settings.global.dmenu = "${pkgs.dmenu}/bin/dmenu -p dunst";
  #services.easyeffects.enable = true;
  services.mako.enable = true;

  #services.blueman-applet.enable = true;
  #services.fluidsynth.enable = true;
  #services.fluidsynth.soundFont = "${pkgs.soundfont-fluid}/share/soundfonts/FluidR3_GM2-2.sf2";
  services.fluidsynth.soundFont = "/nix/var/nix/profiles/per-user/erry/soundfonts/share/soundfonts/SGM-V2.01.sf2";
  #services.fluidsynth.soundFont = "/nix/var/nix/profiles/per-user/erry/soundfonts/share/soundfonts/titanic.sf2";
  services.fluidsynth.soundService = "pipewire-pulse";
  #services.megasync.enable = true;
  services.mpris-proxy.enable = true;

  home.packages = [
    apexctl
    #ffmpeg-rav1e
    github-clone
    noexec
    passmenu-patient
    pscrcpy
    #rigsofrods
    winelegacy
    wine32
    wine64
    #zutty

    #pkgs.anbox
    pkgs.appimage-run
    pkgs.ascii
    pkgs.bat
    pkgs.bc
    #pkgs.bchunk
    #pkgs.bintools
    #pkgs.blender
    #pkgs.briar-desktop
    #pkgs.chessx
    #pkgs.chromium-bsu
    #pkgs.croc
    #pkgs.dcraw
    pkgs.direnv
    #pkgs.discord
    pkgs.dmenu
    #pkgs.dmenu-wayland
    pkgs.dnsutils
    pkgs.doom-emacs
    #pkgs.dos2unix
    #pkgs.dwarf-fortress # broken 2023-02-15
    pkgs.espeak
    pkgs.ffmpeg-full
    pkgs.file
    #pkgs.gamescope
    #pkgs.gdb
    #pkgs.gdmap # broken 2024-12-28
    #pkgs.ghostscript
    pkgs.gimp
    #pkgs.gparted
    pkgs.grim
    #pkgs.gzdoom
    pkgs.imagemagick
    pkgs.inetutils
    #pkgs.inkscape
    #pkgs.iotop
    pkgs.irssi
    pkgs.jre
    #pkgs.kdenlive # replaced with kdepackages.kdenlive 2025-02-25
    pkgs.killall
    #pkgs.krita
    #pkgs.ledger-live-desktop
    pkgs.libreoffice
    #pkgs.libva-utils
    #pkgs.linux-manual
    pkgs.lm_sensors
    #pkgs.ltrace
    (pkgs.lua5_3.withPackages (ps: [ ps.lpeg ]))
    #(pkgs.luajit_2_1.withPackages (ps: [ ps.lpeg ]))
    pkgs.lua-language-server
    #pkgs.lutris
    pkgs.man-pages
    pkgs.man-pages-posix
    #pkgs.megasync
    #pkgs.melonDS
    #pkgs.microsoft-edge
    pkgs.minetest
    pkgs.moreutils
    #pkgs.mumble # broken 2025-03-16
    pkgs.ncdu
    #pkgs.nixfmt
    pkgs.nixos-option
    pkgs.nix-output-monitor
    #pkgs.nixpkgs-fmt
    pkgs.nmap
    #pkgs.nodejs
    #pkgs.nvtopPackages.amd
    (pkgs.openrgb.overrideAttrs
      (finalAttrs: prevAttrs: { patches = [ ./openrgb-oldapex.patch ]; }))
    pkgs.openssl
    #pkgs.osu-lazer
    pkgs.p7zip
    pkgs.pagemon
    pkgs.pavucontrol
    pkgs.pciutils
    pkgs.pcsx2
    #pkgs.pcsxr
    #pkgs.piper
    #pkgs.polymc
    #pkgs.poppler_utils
    pkgs.prismlauncher
    #(pkgs.prismlauncher.overrideAttrs
    #  (finalAttrs: prevAttrs: { patches = [ ./prismlauncher-crack.patch ]; }))
    #pkgs.protontricks
    pkgs.pv
    (pkgs.python3.withPackages (ps: [ ps.matplotlib ps.more-itertools ps.numpy ps.sympy ]))
    #pkgs.qemu_full
    pkgs.qrencode
    #pkgs.qpwgraph
    #pkgs.qtox
    pkgs.ripcord
    pkgs.rm-improved
    #pkgs.sameboy
    pkgs.scanmem
    pkgs.scrot
    pkgs.shellcheck
    pkgs.slurp
    pkgs.socat
    pkgs.speechd
    #pkgs.steamcmd
    #pkgs.strongswan
    #pkgs.superTuxKart
    pkgs.syncplay
    pkgs.texstudio
    #pkgs.turbovnc
    pkgs.unzip
    pkgs.usbutils
    #pkgs.vdpauinfo
    pkgs.vesktop
    #pkgs.vgmstream
    pkgs.vlc
    #pkgs.vttest
    pkgs.wget
    #pkgs.winePackages.waylandFull
    #pkgs.wineWowPackages.waylandFull
    #pkgs.winetricks
    pkgs.wl-clipboard
    pkgs.xdotool
    #pkgs.xonotic
    pkgs.xorg.xkill
    pkgs.xterm
    #pkgs.ydotool
    pkgs.zip
    #pkgs.zopfli
  ];
}
