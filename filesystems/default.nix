{ config, pkgs, ... }:
{
    imports = [
        ./disk.nix
    ];

   boot.loader.grub.enable = true;
   boot.loader.grub.efiSupport = true;
}