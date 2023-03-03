{ pkgs, ... }:

{
  nixpkgs.overlays = [(_: pkgs: { openssh = pkgs.openssh.override { withFIDO = true; }; })];
  programs.ssh.enable = true;
  programs.ssh.controlMaster = "yes";
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
  #  soon.hostname = "192.168.1.76";
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

    vps4.host = "vps-04b3828b-v4";
    vps4.hostname = "vps-04b3828b.vps.ovh.net";
    vps4.port = 22;
    vps4.user = "ubuntu";
    vps4.identitiesOnly = true;
    vps4.addressFamily = "inet";

    smol.host = "smol";
  #  smol.hostname = "192.168.1.73";
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

    github.host = "github.com";
    github.hostname = "github.com";
    github.port = 22;
    github.user = "git";
    github.identitiesOnly = true;

    ubi.host = "ubi.pt";
    ubi.hostname = "unix.ubi.pt";
    ubi.port = 22;
    ubi.user = "a43501";
    ubi.identitiesOnly = true;
    ubi.proxyJump = "soon-prime";
  };
  programs.ssh.serverAliveInterval = 60;
}
