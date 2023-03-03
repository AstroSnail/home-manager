{ pkgs, ... }:

{
  systemd.user.services.weechat = {
    Unit.Description = "WeeChat IM chat client";
    Unit.After = [ "network.target" ];
    Service.Type = "forking";
    Service.ExecStart = "${pkgs.abduco}/bin/abduco -n weechat ${pkgs.weechat}/bin/weechat";
    Service.Environment = "TERM=xterm-256color";
    Install.WantedBy = [ "default.target" ];
  };
}
