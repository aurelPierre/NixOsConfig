{ config, pkgs, ... }:
{
    imports = [
        ./filesystems/default.nix
        ./gui/default.nix
        ./security/default.nix
        ./tools/default.nix
        ./network/default.nix
        ./users/default.nix
    ];

	time.timeZone = "Europe/Paris";
	
	services.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		pulse.enable = true;
	};

    system.stateVersion = "26.05";
}