sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount ./disk.nix
nixos-generate-config --no-filesystems --root /mnt