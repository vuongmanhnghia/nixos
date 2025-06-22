{ config, pkgs, ... }:

{
  imports = [
    ./boot.nix
    ./networking.nix
    ./locale.nix
    # ./security.nix
    ./users.nix
    ./packages.nix
    ./firewall.nix
  ];
}
