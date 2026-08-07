{
  description = "Custom NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    myconfig.url = "github:aurelPierre/NixOsConfig";
  };

  outputs = { self, nixpkgs, myconfig, ... }:
  {
    nixosConfigurations.local =
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          myconfig.NixOsConfig.default

            ./hardware-configuration.nix
        ];
      };
  };
}