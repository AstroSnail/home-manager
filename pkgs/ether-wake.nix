{ lib, stdenv, fetchurl }:

stdenv.mkDerivation (finalAttrs: {
  pname = "ether-wake";
  version = "1.09";

  src = fetchurl {
    url = "mirror://debian/pool/main/e/etherwake/etherwake_${finalAttrs.version}.orig.tar.gz";
    hash = "sha256-VCQcdolXnchuKeavvG1g5p+XE1CRoTlcihD21aLa7B0=";
  };

  patches = [
    # combines part of fix-hardening.patch from debian (the rest introduces a
    # regression) and expands tabs to spaces in help strings
    ./ether-wake-fix.patch
  ];

  buildPhase = ''
    gcc -O -Wall -o ether-wake ether-wake.c
  '';

  installPhase = ''
    install -d $out/bin
    install ether-wake $out/bin
  '';

  meta = {
    description = "tool to send magic Wake-on-LAN packets";
    homepage = "https://web.archive.org/web/20060411015205/http://www.scyld.com/wakeonlan.html";
    license = lib.licenses.gpl2Plus;
    mainProgram = "ether-wake";
    platforms = lib.platforms.unix;
  };
})
