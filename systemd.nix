{ config, lib, pkgs, ... }:

{
  imports = [
    # ./doom-upgrade.nix
  ];

  # systemd.user.startServices = "suggest";
}
