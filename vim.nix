{ config, lib, pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {

      vim-full = prev.vim-full.overrideAttrs (finalAttrs: prevAttrs: {
        patches = (prevAttrs.patches or []) ++ [
          ./patches/vim-rgb-resp.patch
          ./patches/vim-term.patch
        ];
      });

      vimPlugins = prev.vimPlugins // {
        vim-erry = final.vimUtils.buildVimPlugin {
          pname = "vim-erry";
          version = "0.1.0";
          src = ./vim-erry;
        };
      };

      vim-drop = final.callPackage ./pkgs/vim-drop.nix {
        jq = config.programs.jq.package;
      };

      vim-edit = final.callPackage ./pkgs/vim-edit.nix { };

    })
  ];

  home.packages = [
    pkgs.vim-drop
    pkgs.vim-edit
  ];

  programs.vim.enable = true;
  # programs.vim.packageConfigurable = pkgs.vim-erry;
  # programs.vim.defaultEditor = true; # see terminal-specific.sh
  programs.vim.plugins = lib.mkForce [ # remove vim-sensible
    pkgs.vimPlugins.vim-erry
    pkgs.vimPlugins.vim-easymotion
    # pkgs.vimPlugins.vim-airline
    # pkgs.vimPlugins.vim-fugitive
  ];
  programs.vim.extraConfig = ''
    source ${./vimrc}
  '';
}
