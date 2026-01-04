{ pkgs, ... }: {
  programs.git.enable = true;
  programs.git.package = pkgs.gitFull;
  programs.git.lfs.enable = true;
  programs.git.signing.key = "8309F7A6A812A754F678F2F8C9936558DFAA3AA2";
  programs.git.signing.signByDefault = true;
  programs.git.settings.user.name = "AstroSnail";
  programs.git.settings.user.email = "astrosnail@protonmail.com";
  programs.git.settings.merge.conflictStyle = "zdiff3";
}
