{ config, pkgs, ... }:
{
    imports = [
        ./filesystems/default.nix
        ./gui/default.nix
        ./security/default.nix
        ./tools/default.nix
        ./network/default.nix
        ./users/default.nix
    ];

    system.stateVersion = "26.05";
}