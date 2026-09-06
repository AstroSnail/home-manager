{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      mpv-unwrapped =
        prev.mpv-unwrapped.override { ffmpeg = final.ffmpeg-full; };
    })
    #(final: prev: {
    #  mpv = prev.mpv.override {
    #    extraMakeWrapperArgs =
    #      [ "--prefix" "PATH" ":" (lib.makeBinPath [ pkgs.xclip ]) ];
    #  };
    #})
  ];

  home.shellAliases.diveo = "mpv --profile=diveo";
  home.shellAliases.duaio = "mpv --profile=duaio";

  programs.mpv.enable = true;
  programs.mpv.includes = [ "${./mpv.conf}" ];

  programs.streamlink.enable = true;
  programs.streamlink.settings.player = "mpv";
  programs.streamlink.settings.twitch-low-latency = true;
}
