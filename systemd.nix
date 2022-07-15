{ pkgs, ... }:

let
  nixPathStrings = [
    "/home/erry/.nix-defexpr/channels"
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    "nixos-config=/etc/nixos/configuration.nix"
    "/nix/var/nix/profiles/per-user/root/channels"
  ];
  nixPathEnv = builtins.concatStringsSep ":" nixPathStrings;

in {
  systemd.user.services.home-manager-auto-upgrade.Service.Environment = "'PATH=${pkgs.nix}/bin' 'NIX_PATH=${nixPathEnv}' 'NO_COLOR=1'";
}
