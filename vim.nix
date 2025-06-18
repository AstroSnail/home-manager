{ lib, pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      vimPlugins = prev.vimPlugins // {
        vim-erry = final.vimUtils.buildVimPlugin {
          name = "vim-erry";
          src = ./vim-erry;
        };
      };
    })
  ];

  programs.vim.enable = true;
  programs.vim.plugins = lib.mkForce [ # remove vim-sensible
    pkgs.vimPlugins.vim-erry
    pkgs.vimPlugins.easymotion
  ];
  programs.vim.extraConfig = ''
    source ${./vimrc}
  '';
}
