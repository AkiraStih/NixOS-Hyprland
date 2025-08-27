{ config, pkgs, lib, ... }: {

	imports = [
		./hardware-configuration.nix
		./modules.nix
	];
	i18n.defaultLocale = "en_US.UTF-8";

  programs.nh = {
    enable = true;
    flake = "/home/mafien0/nix";
  };

  home-manager.backupFileExtension = "backup";

	networking = {
		networkmanager.enable = true;
		hostName = "nixos";
	};

	time = {
		timeZone = "Europe/Moscow";
		hardwareClockInLocalTime = true;
	};

	services.displayManager.ly.enable = true;
  services.openssh.enable = true;
	nix.settings.experimental-features = ["nix-command" "flakes"];
	nixpkgs.config.allowUnfree = true;
	system.stateVersion = "25.05";
}

