{ pkgs, ... }:

{
  #nixpkgs.overlays = [(_: pkgs: { openssh = pkgs.openssh.override { withFIDO = true; }; })];
  programs.ssh.enable = true;
  programs.ssh.controlMaster = "auto";
  programs.ssh.serverAliveInterval = 60;
  programs.ssh.extraOptionOverrides = { ConnectTimeout = "10"; };
  programs.ssh.matchBlocks = {
    #snail.host = "snail";
    #snail.hostname = "192.168.1.65";
    #snail.port = 22;
    #snail.user = "astro";
    #snail.identitiesOnly = true;

    #git.host = "git.astrosnail.pt.eu.org";
    #git.hostname = "192.168.1.65";
    #git.port = 22;
    #git.user = "git";
    #git.identitiesOnly = true;

    soon.host = "soon";
    #soon.hostname = "192.168.1.75";
    #soon.hostname = "192.168.1.76";
    soon.hostname = "fd57:337f:9040:1:2:3:4:5";
    soon.port = 22;
    soon.user = "erry";
    soon.identitiesOnly = true;

    sea.host = "sea";
    sea.hostname = "fd57:337f:9040:1::5ea";
    #sea.hostname = "2001:41d0:304:200::4150";
    sea.port = 22;
    sea.user = "ubuntu";
    sea.identitiesOnly = true;

    vps.host = "vps-04b3828b";
    vps.hostname = "vps-04b3828b.vps.ovh.net";
    vps.port = 22;
    vps.user = "ubuntu";
    vps.identitiesOnly = true;
    vps.addressFamily = "inet6";

    vps-4.host = "vps-04b3828b-v4";
    vps-4.hostname = "vps-04b3828b.vps.ovh.net";
    vps-4.port = 22;
    vps-4.user = "ubuntu";
    vps-4.identitiesOnly = true;
    vps-4.addressFamily = "inet";

    smol.host = "smol";
    #smol.hostname = "192.168.1.73";
    #smol.hostname = "192.168.1.74";
    smol.hostname = "fd57:337f:9040:1:1:1:1:2";
    smol.port = 22;
    smol.user = "kit";
    smol.identitiesOnly = true;

    soon-prime.host = "soon-prime";
    soon-prime.hostname = "fd57:337f:9040:1:5:4:3:2";
    soon-prime.port = 22;
    soon-prime.user = "izzy";
    soon-prime.identitiesOnly = true;

    sunrise.host = "sunrise";
    sunrise.hostname = "2a01:4f8:c0c:1013::1";
    sunrise.port = 22;
    sunrise.user = "root";
    sunrise.identitiesOnly = true;

    sunrise-v4.host = "sunrise-v4";
    sunrise-v4.hostname = "162.55.184.64";
    sunrise-v4.port = 22;
    sunrise-v4.user = "root";
    sunrise-v4.identitiesOnly = true;

    vps2.host = "vps-c7e9a3a0";
    vps2.hostname = "vps-c7e9a3a0.vps.ovh.ca";
    vps2.port = 22;
    vps2.user = "debian";
    vps2.identitiesOnly = true;
    vps2.addressFamily = "inet6";

    vps2-4.host = "vps-c7e9a3a0-v4";
    vps2-4.hostname = "vps-c7e9a3a0.vps.ovh.ca";
    vps2-4.port = 22;
    vps2-4.user = "debian";
    vps2-4.identitiesOnly = true;
    vps2-4.addressFamily = "inet";

    github.host = "github.com";
    github.hostname = "github.com";
    github.port = 22;
    github.user = "git";
    github.identitiesOnly = true;
    #github.addressFamily = "inet6"; # ????

    ubi.host = "ubi.pt";
    ubi.hostname = "unix.ubi.pt";
    ubi.port = 22;
    ubi.user = "a43501";
    ubi.identitiesOnly = true;
    ubi.proxyJump = "soon-prime";
  };
}
