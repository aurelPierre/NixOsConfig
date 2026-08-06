{ config, pkgs, ... }:
{
    networking.useDHCP = false;
    networking.networkmanager.enable = true;

    environment.systemPackages = with pkgs; [
        proton-vpn
    ];
}