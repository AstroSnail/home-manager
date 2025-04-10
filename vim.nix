{ lib, pkgs, ... }:

{
  programs.vim.enable = true;
  programs.vim.plugins = lib.mkForce [
    (pkgs.vimUtils.buildVimPlugin {
      name = "vim-erry";
      src = ./vim-erry;
    })
    pkgs.vimPlugins.easymotion
  ];
  programs.vim.extraConfig = ''
    source ${./vimrc}
  '';
}
