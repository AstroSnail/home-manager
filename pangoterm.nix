{ lib, stdenv, fetchbzr, libtool, pkg-config, cairo, gtk2, libvterm-neovim }:

stdenv.mkDerivation (finalAttrs: {
  pname = "pangoterm";
  version = "635";

  src = fetchbzr {
    url = "http://bazaar.leonerd.org.uk/code/pangoterm/";
    sha256 = "sha256-VoK05DNSdZ6q1BlJW0tow2yNffYqDQVFLmsQpTsRvCU=";
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
