{ config, pkgs, ... }:

{
  systemd.user.services.icynet-canvas-update = {
    Unit.Description = "IcyNet canvas updater";
    Unit.After = [ "network-online.target" ];
    Service.Type = "oneshot";
    Service.ExecStart =
      "${pkgs.curl}/bin/curl --fail --output ${config.xdg.userDirs.pictures}/draw.icynet.eu-canvas.png https://draw.icynet.eu/canvas.png";
    Service.Restart = "on-failure";
  };

  systemd.user.timers.icynet-canvas-update = {
    Unit.Description = "IcyNet canvas update timer";
    Timer.OnCalendar = "hourly";
    Install.WantedBy = [ "timers.target" ];
  };
}
