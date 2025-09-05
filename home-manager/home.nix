{ pkgs, ... }:{
	imports = [
		./modules.nix

	];

	home = {
		username = "bogdan";
		homeDirectory = "/home/bogdan";
		stateVersion = "25.05";
};
home-manager.backupFileExtension = "backup";


home.packages = with pkgs; [
    # ... другие ваши пакеты
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk # GTK нужен как запасной вариант для многих приложений
  ];
}
