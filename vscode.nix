{ pkgs, ... }:

{
  programs.vscode.enable = true;
  programs.vscode.mutableExtensionsDir = false;
  programs.vscode.profiles.default.extensions = let
    ext = pkgs.vscode-extensions;
  in [
    ext.ms-vsliveshare.vsliveshare
    ext.sumneko.lua
    ext.james-yu.latex-workshop
    ext.ms-vscode.cpptools
    ext.ms-vscode.hexeditor
    ext.ms-vscode.cmake-tools
    #ext.twxs.cmake
    ext.rust-lang.rust-analyzer
    ext.mkhl.direnv
    ext.editorconfig.editorconfig
    ext.eamodio.gitlens
    ext.jnoortheen.nix-ide
    ext.continue.continue
  ] ++ (pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    # TODO: figure out auto-update for these
    # e.g. https://github.com/nix-community/nix-vscode-extensions
    # also wanted: meronz.manpages
    #{
    #  name = "cursorless";
    #  publisher = "pokey";
    #  version = "0.26.495";
    #  sha256 = "sha256-VR1LMA86WRszU/66eP+aH7iAm4yxsMHhMPCIWFtYJfc=";
    #}
    #{
    #  name = "parse-tree";
    #  publisher = "pokey";
    #  version = "0.28.2";
    #  sha256 = "sha256-pqf3/GaKkrBBHPTGcfPHo3p4Ja5a/YrQ7dSOjP1Lc2o=";
    #}
    #{
    #  name = "vscode-capnp";
    #  publisher = "xmonader";
    #  version = "1.0.0";
    #  sha256 = "sha256-zIkiDaWWay+6U4aA4ioTy/9MUk9mD+NLHX7kjQ2FWnw=";
    #}
    #{
    #  name = "second-local-lua-debugger-vscode";
    #  publisher = "ismoh-games";
    #  version = "0.3.8";
    #  sha256 = "sha256-xuOIBBnVWNREAAkAXkdSEsdqM49g+ngmNKtgJWrATNA=";
    #}
  ]);
}
