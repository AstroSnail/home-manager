{ lib, pkgs, ... }:

{
  systemd.user.services.doom-upgrade = {
    Unit.Description = "Doom emacs upgrade";
    Unit.After = [ "network-online.target" ];
    Service.Type = "oneshot";
    Service.ExecStart = "${lib.getExe pkgs.doom-emacs} upgrade --force";
    Service.Restart = "on-failure";
  };

  systemd.user.timers.doom-upgrade = {
    Unit.Description = "Doom emacs upgrade timer";
    Timer.OnCalendar = "daily";
    Install.WantedBy = [ "timers.target" ];
  };
}
