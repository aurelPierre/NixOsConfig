{ config, pkgs, ... }:
{
    imports = [
        ./hardware-configuration.nix
        ./filesystems/default.nix
        ./gui/default.nix
        ./security/default.nix
        ./tools/default.nix
        ./network/default.nix
    ];

    system.stateVersion = "26.05";
}