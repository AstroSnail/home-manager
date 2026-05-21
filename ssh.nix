{ pkgs, ... }:

{
  #nixpkgs.overlays = [(_: pkgs: { openssh = pkgs.openssh.override { withFIDO = true; }; })];
  programs.ssh.enable = true;
  programs.ssh.enableDefaultConfig = false;

  programs.ssh.settings."*" = {
    ForwardAgent = false;
    AddKeysToAgent = "no";
    Compression = false;
    ServerAliveInterval = 60;
    ServerAliveCountMax = 3;
    HashKnownHosts = false;
    UserKnownHostsFile = "~/.ssh/known_hosts";
    ControlMaster = "auto";
    ControlPath = "~/.ssh/master-%r@%n:%p";
    ControlPersist = "no";
    ConnectTimeout = 10;
  };

  # programs.ssh.settings."snail" = {
  #   HostName = "192.168.1.65";
  #   Port = 22;
  #   User = "astro";
  #   IdentitiesOnly = true;
  # };

  # programs.ssh.settings."git.astrosnail.pt.eu.org" = {
  #   HostName = "192.168.1.65";
  #   Port = 22;
  #   User = "git";
  #   IdentitiesOnly = true;
  # };

  programs.ssh.settings."soon" = {
    HostName = "192.168.1.64";
    # HostName = "fd57:337f:9040:1:2:3:4:5";
    Port = 22;
    User = "erry";
    IdentitiesOnly = true;
  };

  # programs.ssh.settings."smol" = {
  #   # HostName = "192.168.1.73";
  #   # HostName = "192.168.1.74";
  #   HostName = "fd57:337f:9040:1:1:1:1:2";
  #   Port = 22;
  #   User = "kit";
  #   IdentitiesOnly = true;
  # };

  # programs.ssh.settings."soon-prime" = {
  #   HostName = "fd57:337f:9040:1:5:4:3:2";
  #   Port = 22;
  #   User = "izzy";
  #   IdentitiesOnly = true;
  # };

  # OVH Gravelines
  # programs.ssh.settings."sea" = {
  #   HostName = "fd57:337f:9040:1::5ea";
  #   # HostName = "2001:41d0:304:200::4150";
  #   Port = 22;
  #   User = "ubuntu";
  #   IdentitiesOnly = true;
  # };

  programs.ssh.settings."vps-04b3828b" = {
    HostName = "vps-04b3828b.vps.ovh.net";
    Port = 22;
    User = "ubuntu";
    IdentitiesOnly = true;
    AddressFamily = "inet6";
  };

  programs.ssh.settings."vps-04b3828b-v4" = {
    HostName = "vps-04b3828b.vps.ovh.net";
    Port = 22;
    User = "ubuntu";
    IdentitiesOnly = true;
    AddressFamily = "inet";
  };

  # OVH Beauharnois
  programs.ssh.settings."vps-c7e9a3a0" = {
    HostName = "vps-c7e9a3a0.vps.ovh.ca";
    Port = 22;
    User = "debian";
    IdentitiesOnly = true;
    AddressFamily = "inet6";
  };

  programs.ssh.settings."vps-c7e9a3a0-v4" = {
    HostName = "vps-c7e9a3a0.vps.ovh.ca";
    Port = 22;
    User = "debian";
    IdentitiesOnly = true;
    AddressFamily = "inet";
  };

  # Hetzner Nürnberg
  programs.ssh.settings."sunrise" = {
    HostName = "2a01:4f8:c0c:1013::1";
    Port = 22;
    User = "root";
    IdentitiesOnly = true;
  };

  programs.ssh.settings."sunrise-v4" = {
    HostName = "162.55.184.64";
    Port = 22;
    User = "root";
    IdentitiesOnly = true;
  };

  programs.ssh.settings."github.com" = {
    HostName = "github.com";
    Port = 22;
    User = "git";
    IdentitiesOnly = true;
    # AddressFamily = "inet6"; # ????
  };

  # programs.ssh.settings."ubi.pt" = {
  #   HostName = "unix.ubi.pt";
  #   Port = 22;
  #   User = "a43501";
  #   IdentitiesOnly = true;
  #   ProxyJump = "soon-prime";
  # };
}
