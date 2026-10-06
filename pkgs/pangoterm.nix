{ lib, stdenv, fetchbzr, libtool, pkg-config, cairo, gtk2, libvterm-neovim }:

stdenv.mkDerivation (finalAttrs: {
  pname = "pangoterm";
  version = "635";

  src = fetchbzr {
    url = "http://bazaar.leonerd.org.uk/code/pangoterm/";
    rev = finalAttrs.version;
    sha256 = "sha256-zik+LNwAPsr2rFqxyXZrZkglf9+JWQ/rM0wItgdT1MA=";
  };

  nativeBuildInputs = [
    libtool
    pkg-config
  ];

  buildInputs = [
    cairo
    gtk2
    libvterm-neovim
  ];

  makeFlags = [
    "PREFIX=$(out)"
  ];

  meta = {
    description = "GTK/Pango-based terminal";
    homepage = "http://www.leonerd.org.uk/code/pangoterm/";
    license = lib.licenses.mit;
    mainProgram = "pangoterm";
    platforms = lib.platforms.unix;
  };
})
