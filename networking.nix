{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      ether-wake = final.callPackage ./pkgs/ether-wake.nix { };
    })
  ];

  home.packages = [
    #pkgs.dnsutils
    pkgs.ether-wake
    #pkgs.inetutils
    # pkgs.net-tools
    #pkgs.nmap
    #pkgs.socat
    pkgs.wakeonlan
    pkgs.wol
  ];
}
