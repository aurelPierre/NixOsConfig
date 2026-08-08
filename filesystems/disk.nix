{
	disko.devices = {
		disk = {
			disk1 = {
				device = "/dev/nvme0n1";
				type = "disk";
				content = {
					type = "gpt";
					partitions = {
						ESP = {
							end = "+1G";
							type = "EF00";
							content = {
								type = "filesystem";
								format = "vfat";
								mountpoint = "/boot";
							};
						};
						crypt_p1 = {
							size = "100%";
							content = {
								type = "luks";
								name = "p1";
								settings = {
									allowDiscards = true;
								};
												};
						};
					};
				};
			};
			disk2 = {
				device = "/dev/nvme1n1";
				type = "disk";
				content = {
					type = "gpt";
					partitions = {
						crypt_p2 = {
							size = "100%";
							content = {
								type = "luks";
								name = "p2";
								settings = {
									allowDiscards = true;
								};
								content = {
									type = "btrfs";
									extraArgs = [
										"-d raid1"
										"/dev/mapper/p1"
									];
									mountpoint = "/";
									subvolumes = {
										"/home" = {
											mountpoint = "/home";
											mountOptions = [
												"compress=zstd"
													"noatime"
													"nosuid"
													"nodev"
											];
										};
										"/var" = {
											mountpoint = "/var";
											mountOptions = [
												"compress=zstd"
													"noatime"
											];
										};
										"/nix" = {
											mountpoint = "/nix";
											mountOptions = [
												"compress=zstd"
													"noatime"
											];
										};
										"/work" = {
											mountpoint = "/work";
											mountOptions = [
												"compress=zstd"
												"noatime"
												"nosuid"
												"nodev"
											];
										};
									};
								};
							};
						};
					};
				};
			};
		};

	};
}
