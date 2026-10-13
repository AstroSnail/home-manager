{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      github-clone = final.callPackage ./pkgs/github-clone.nix { };
    })
  ];

  home.packages = [
    pkgs.github-clone
  ];

  programs.git.enable = true;
  programs.git.package = pkgs.gitFull;
  # programs.git.lfs.enable = true;
  programs.git.signing.key = "8309F7A6A812A754F678F2F8C9936558DFAA3AA2";
  programs.git.signing.signByDefault = true;
  programs.git.signing.format = "openpgp";
  programs.git.settings.merge.conflictStyle = "zdiff3";
  # TODO: get primary
  # programs.git.settings.sendemail.identity = "astrosnail-plfgr";
  programs.git.settings.user.name = "AstroSnail";
  programs.git.settings.user.email = "astrosnail@plfgr.eu.org";
}
