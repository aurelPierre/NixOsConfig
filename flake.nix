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

      runtimeInputs = [
        disko.packages.${system}.default
      ];

      text = ''
        set -euo pipefail

        echo "Formatting and mounting disks..."

        disko --mode destroy,format,mount ${./filesystems/disk.nix}

        echo "Generating hardware configuration..."

        nixos-generate-config --no-filesystems --root /mnt

        echo "Creating local flake..."

        cp ${./installer/flake.template.nix} /mnt/etc/nixos/flake.nix
        nix flake lock /mnt/etc/nixos --extra-experimental-features "nix-command flakes"

        echo "Installing..."

        nixos-install --root /mnt --flake /mnt/etc/nixos#local
      '';
    };
  in
  {
    nixosModules.default = {
      imports = [
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