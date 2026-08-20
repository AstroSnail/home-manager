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
    ControlPath = "~/.ssh/control-%r@[%h]:%p";
    ControlPersist = "no";
    ConnectTimeout = 10;
    # SendEnv = [ "VTE_VERSION" ];
  };

  # programs.ssh.settings."soon" = {
  #   HostName = "192.168.1.64";
  #   # HostName = "fd57:337f:9040:1:2:3:4:5";
  #   Port = 22;
  #   User = "erry";
  #   IdentitiesOnly = true;
  # };

  # OVH Gravelines
  programs.ssh.settings."sea" = {
    HostName = "vps-04b3828b.vps.ovh.net";
    Port = 22;
    User = "ubuntu";
    IdentitiesOnly = true;
    AddressFamily = "inet6";
  };

  programs.ssh.settings."sea-v4" = {
    HostName = "vps-04b3828b.vps.ovh.net";
    Port = 22;
    User = "ubuntu";
    IdentitiesOnly = true;
    AddressFamily = "inet";
  };

  # Hetzner Nürnberg
  programs.ssh.settings."sunrise" = {
    # HostName = "2a01:4f8:c0c:1013::1";
    HostName = "fddb:e39:ebc9:1::1";
    Port = 22;
    User = "erry";
    IdentitiesOnly = true;
  };

  # programs.ssh.settings."sunrise-v4" = {
  #   HostName = "162.55.184.64";
  #   Port = 22;
  #   User = "erry";
  #   IdentitiesOnly = true;
  # };

  programs.ssh.settings."github.com" = {
    HostName = "github.com";
    Port = 22;
    User = "git";
    IdentitiesOnly = true;
    # AddressFamily = "inet6"; # ????
  };
}
