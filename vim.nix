{ config, lib, pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      vim-erry =
        prev.vim-full.overrideAttrs (finalAttrs: prevAttrs: {
          patches = (prevAttrs.patches or []) ++ [
            ./vim-rgb-resp.patch
            ./vim-term.patch
          ];
        });
      vimPlugins = prev.vimPlugins // {
        vim-erry = final.vimUtils.buildVimPlugin {
          pname = "vim-erry";
          version = "0.1.0";
          src = ./vim-erry;
        };
      };
      vim-drop = pkgs.writeShellApplication {
        name = "vim-drop";
        runtimeInputs = [ config.programs.jq.package ];
        text = lib.readFile ./vim-drop.sh;
      };
      vim-edit = pkgs.writeShellApplication {
        name = "vim-edit";
        runtimeInputs = [ final.vim-drop ];
        text = lib.readFile ./vim-edit.sh;
      };
    })
  ];

  home.packages = [
    pkgs.vim-drop
    pkgs.vim-edit
  ];

  programs.vim.enable = true;
  programs.vim.packageConfigurable = pkgs.vim-erry;
  # NOTE: see also terminal-specific.sh
  programs.vim.defaultEditor = true;
  programs.vim.plugins = lib.mkForce [ # remove vim-sensible
    pkgs.vimPlugins.vim-erry
    pkgs.vimPlugins.vim-easymotion
  ];
  programs.vim.extraConfig = ''
    source ${./vimrc}
  '';
}
