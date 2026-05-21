{ config, lib, pkgs, ... }:

{
  imports = [
    # ./doom-upgrade.nix
    #./icynet-canvas.nix
    # ./ipsave.nix
    #./weechat.nix
  ];

  systemd.user.startServices = "suggest";
}
