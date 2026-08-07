#!/usr/bin/env sh
nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount ./filesystems/disk.nix
nixos-generate-config --no-filesystems --root /mnt
mv * /mnt/etc/nixos/
mv .* /mnt/etc/nixos/
nix flake update --flake /mnt/etc/nixos --experimental-features "nix-command flakes"
nixos-install --flake /mnt/etc/nixos#nixos 