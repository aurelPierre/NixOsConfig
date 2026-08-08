{
	disko.devices = {
		disk = {
			main = {
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
						luks = {
							size = "100%";
							content = {
								type = "luks";
								name = "crypted";
								settings = {
									allowDiscards = true;
								};
								content = {
									type = "btrfs";
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
									};
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
						luks = {
							size = "100%";
							content = {
								type = "luks";
								name = "crypted";
								settings = {
									allowDiscards = true;
								};
								content = {
									type = "btrfs";
									subvolumes = {
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
