{ pkgs, ... }:

{
  systemd.user.services.doom-upgrade = {
    Unit.Description = "Doom emacs upgrade";
    Unit.After = [ "network-online.target" ];
    Service.Type = "oneshot";
    Service.ExecStart = "${pkgs.doom-emacs}/bin/doom upgrade --packages";
  };

  systemd.user.timers.doom-upgrade = {
    Unit.Description = "Doom emacs upgrade timer";
    Timer.OnCalendar = "daily";
    Install.WantedBy = [ "timers.target" ];
  };
}
