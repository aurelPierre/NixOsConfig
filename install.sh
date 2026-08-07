#!/usr/bin/env sh
nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount ./filesystems/disk.nix
nixos-generate-config --no-filesystems --root /mnt
mv ./installer/flake.template.nix /mnt/etc/nixos/flake.nix
nixos-install --flake /mnt/etc/nixos#local 