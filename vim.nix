{ lib, pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      vim-erry =
        prev.vim-full.overrideAttrs (finalAttrs: prevAttrs: {
          patches = (prevAttrs.patches or []) ++ [
            ./vim-auto-tgc.patch
            # ./vim-terminal-env.patch
          ];
        });
    })
    (final: prev: {
      vimPlugins = prev.vimPlugins // {
        vim-erry = final.vimUtils.buildVimPlugin {
          pname = "vim-erry";
          version = "0.1.0";
          src = ./vim-erry;
        };
      };
    })
  ];

  programs.vim.enable = true;
  programs.vim.packageConfigurable = pkgs.vim-erry;
  programs.vim.defaultEditor = true;
  programs.vim.plugins = lib.mkForce [ # remove vim-sensible
    pkgs.vimPlugins.vim-erry
    pkgs.vimPlugins.vim-easymotion
  ];
  programs.vim.extraConfig = ''
    source ${./vimrc}
  '';
}
