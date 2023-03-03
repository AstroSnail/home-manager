{ lib, pkgs, ... }:

let
  nixPathStrings = [
    "/home/erry/.nix-defexpr/channels"
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    "nixos-config=/etc/nixos/configuration.nix"
    "/nix/var/nix/profiles/per-user/root/channels"
  ];
  nixPathEnv = lib.concatStringsSep ":" nixPathStrings;

in {
  imports = [
    ./doom-upgrade.nix
    #./icynet-canvas.nix
    ./ipsave.nix
    ./weechat.nix
  ];

  services.home-manager.autoUpgrade.enable = true;
  services.home-manager.autoUpgrade.frequency = "05:00";
  systemd.user.services.home-manager-auto-upgrade.Service.Environment = "'PATH=${pkgs.nix}/bin' 'NIX_PATH=${nixPathEnv}' 'NO_COLOR=1'";
}
