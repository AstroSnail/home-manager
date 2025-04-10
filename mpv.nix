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
  programs.mpv.enable = true;
  programs.mpv.includes = [ "${./mpv.conf}" ];
}
