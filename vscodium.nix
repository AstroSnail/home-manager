{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      # TODO: vscode-oss with ./vscode-term.patch
      vscodium-erry = final.vscodium;
    })
  ];

  programs.vscodium.enable = true;
  programs.vscodium.package = pkgs.vscodium-erry;
  programs.vscodium.mutableExtensionsDir = false;

  programs.vscodium.profiles.default.extensions = let
    ext = pkgs.vscode-extensions;
  in [
    ext.ms-vsliveshare.vsliveshare
    ext.mkhl.direnv
    ext.editorconfig.editorconfig
  ];
}
