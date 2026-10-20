{ lib, ... }:

# TODO: override prevAttrs.src?

{
  nixpkgs.overlays = [
    (final: prev: {

      # vim-full = prev.vim-full.overrideAttrs (finalAttrs: prevAttrs: let
      #   # version = "9.2.1021";
      #   # hash = "sha256-3GQno5jSGXbbamo4OjGKDCR0ph93nk71ogcmMoBHwoo=";
      #   version = "9.2.1036";
      #   hash = "sha256-4cXM41ciVxuNqocWq38UtTxhZ8TNX7+7acAj1Su97FY=";
      # in if lib.versionOlder prevAttrs.version version then {
      #   inherit version;
      #   src = final.fetchFromGitHub {
      #     owner = "vim";
      #     repo = "vim";
      #     rev = "v${version}";
      #     inherit hash;
      #   };
      # } else {});

      yt-dlp = prev.yt-dlp.overrideAttrs (finalAttrs: prevAttrs: let
        version = "2026.1.29";
        hash = "sha256-ErSJ6xaCjMP/8XI/JEmS666KW/Gtdcjp8B1ymuI367k=";
      in if lib.versionOlder prevAttrs.version version then {
        inherit version;
        src = final.fetchPypi {
          pname = "yt_dlp";
          inherit version hash;
        };
        # postPatch = null;
      } else {});

      zutty = prev.zutty.overrideAttrs (finalAttrs: prevAttrs: let
        version = "0.17";
        rev = "0.17";
        hash = "sha256-0UhAij4ERAdbASE+pCcq6NaaYUaNEa9Fpj642QL/77c=";
      in if lib.versionOlder prevAttrs.version version then {
        inherit version;
        src = final.fetchgit {
          url = "https://git.hq.sig7.se/zutty.git";
          inherit rev hash;
        };
      } else {});

    })
  ];
}
