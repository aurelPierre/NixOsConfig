{ config, pkgs, ... }:
{
    imports = [
        ./disk.nix
        ./gui.nix
    
        "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
    ];
}