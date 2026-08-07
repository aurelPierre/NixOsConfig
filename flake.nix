{
  description = "Custom NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, disko, ... }:
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
    };

    install = pkgs.writeShellApplication {
      name = "install";

      text = ''
        set -euo pipefail

        echo "Formatting and mounting disks..."

        nix run ${disko} -- \
          --mode destroy,format,mount \
          ${./filesystems/disk.nix}

        echo "Generating hardware configuration..."

        nixos-generate-config --no-filesystems --root /mnt

        echo "Creating local flake..."

        cp ${./installer/flake.template.nix} /mnt/etc/nixos/flake.nix

        echo "Installing..."

        nixos-install --flake /mnt/etc/nixos#local
      '';
    };
  in
  {
    nixosConfigurations.nixos =
      nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          disko.nixosModules.disko
          ./default.nix
        ];
      };

    apps.${system}.install = {
      type = "app";
      program = "${install}/bin/install";
    };
  };
}