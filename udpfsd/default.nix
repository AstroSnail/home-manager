{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule (finalAttrs: {
  pname = "udpfsd";
  version = "0.1.5";

  src = fetchFromGitHub {
    owner = "pcm720";
    repo = "udpfsd";
    tag = "v${finalAttrs.version}";
    hash = "sha256-NRCUByiC26Hml3kVOAtiU61wfp7Y6jtuqbzOFJeM8eg=";
  };

  vendorHash = "sha256-KucBViUrbxTuNYOfqJVbde5VxsRvRR3gGQRe5cG3RTg=";
  tags = [ "nochd" ];
  preCheck = ''
    rm internal/fs/compression/chd/chd_test.go
  '';

  meta = {
    description = "A UDPFS server written in Go";
    mainProgram = "udpfsd";
    platforms = lib.platforms.all;
  };
})
