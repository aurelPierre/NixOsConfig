{ config, pkgs, ... }:
{
    imports = [
        ./filesystems/default.nix
        ./gui/default.nix
    ];
}