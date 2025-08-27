{ config, pkgs, lib, ... }: {

	imports = [
		./hardware-configuration.nix
		./modules.nix
	];
	i18n.defaultLocale = "en_US.UTF-8";


  home-manager.backupFileExtension = "backup";
	boot.kernelParams = [ "mem_sleep_default=s2idle" ];

  programs.nh = {
    enable = true;
    flake = "/home/bogdan/nix";
  };
	# Включаем TUN-модуль для ядра
	boot.kernelModules = [ "tun" ];
	
	# Разрешаем пользователям создавать TUN-устройства
	networking.extraHosts = ''
	  # иногда нужно, но можно пропустить
	'';
	
	# Если нужен systemd-udev для TUN
	services.udev.extraRules = ''
	  KERNEL=="tun", NAME="tun", MODE="0666"
	'';


	networking = {
		networkmanager.enable = true;
		hostName = "nixos";
	};

	time = {
		timeZone = "Europe/Moscow";
		hardwareClockInLocalTime = true;
	};

	services.displayManager.ly.enable = true;
	hardware.enableRedistributableFirmware = true;

	nix.settings.experimental-features = ["nix-command" "flakes"];
	nixpkgs.config.allowUnfree = true;
	system.stateVersion = "25.05";
}

