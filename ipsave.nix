{ config, lib, pkgs, ... }:

let
  ipsave = pkgs.writeShellApplication {
    name = "ipsave";
    runtimeInputs = [ pkgs.coreutils pkgs.openssh ];
    text = lib.readFile ./ipsave.sh;
  };

  ipsave-service = description: args: {
    Unit.Description = description;
    Unit.After = [ "network-online.target" ];
    Service.Type = "oneshot";
    Service.ExecStart = "${ipsave}/bin/ipsave ${args}";
    Service.Restart = "on-failure";
  };

in {
  systemd.user.services.ipv4save = ipsave-service "IPv4 logger script"
    "vps-04b3828b-v4 ${config.xdg.userDirs.documents}/admin/ip.log";
  systemd.user.services.ipv6save = ipsave-service "IPv6 logger script"
    "vps-04b3828b ${config.xdg.userDirs.documents}/admin/ip6.log";

  systemd.user.timers."ipsave@" = {
    Unit.Description = "IP logger timer: %i";
    Timer.Unit = [ "%i.service" ];
    Timer.OnCalendar = "daily";
    Timer.RandomizedDelaySec = "12h";
    Install.WantedBy = [ "timers.target" ];
  };
}
