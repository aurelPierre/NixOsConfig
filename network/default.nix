{ config, pkgs, ... }:
{
    networking.useDHCP = false;
    networking.networkmanager.enable = true;

    environment.systemPackages = [
        proton-vpn
    ];
}