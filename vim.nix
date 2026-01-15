{ lib, pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      vim-erry =
        prev.vim-full.overrideAttrs (oldattrs: {
          patches = oldattrs.patches ++ [
            ./vim-termguicolors.patch
            # ./vim-terminal-env.patch
            ./vim-19145.patch
            # ./vim-19181.patch
          ];
        });
    })
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
  programs.vim.packageConfigurable = pkgs.vim-erry;
  programs.vim.defaultEditor = true;
  programs.vim.plugins = lib.mkForce [ # remove vim-sensible
    pkgs.vimPlugins.vim-erry
    pkgs.vimPlugins.easymotion
  ];
  programs.vim.extraConfig = ''
    source ${./vimrc}
  '';
}
