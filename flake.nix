{
	description = "NixOS configuration with unstable nixpkgs and Home Manager";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    	nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

		nixos-hardware.url = "github:NixOS/nixos-hardware/master";

		home-manager = {
			url = "github:nix-community/home-manager/release-25.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		stylix = {
			url = "github:nix-community/stylix/release-25.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nixvim = {
			url = "github:nix-community/nixvim";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nixcord = {
			url = "github:kaylorben/nixcord";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		spicetify-nix = {
			url = "github:Gerg-L/spicetify-nix";
			inputs.nixpkgs.follows = "nixpkgs";
		};

	};

	outputs = inputs@{ 
		nixpkgs,
		home-manager,
		stylix,
		nixvim,
		nixcord,
		spicetify-nix,
		nixpkgs-unstable,
		nixos-hardware,
		... }: let
			system = "x86_64-linux";

			pkgs = import nixpkgs {
				inherit system;
				config.allowUnfree = true;
			};
		in {
			nixosConfigurations = {
				nixos = nixpkgs.lib.nixosSystem {
					inherit system;
					modules = [
						./nixos/configuration.nix
						home-manager.nixosModules.home-manager
						nixos-hardware.nixosModules.lenovo-thinkpad-t480
					];

					specialArgs = {
						inherit inputs system;
						unstable = nixpkgs-unstable.legacyPackages.x86_64-linux;
					};
				};
			};

			homeConfigurations = {
				bogdan = home-manager.lib.homeManagerConfiguration {
					inherit pkgs;
					extraSpecialArgs = {
						inherit inputs system;
					};
					modules = [
						./home-manager/home.nix
						stylix.homeModules.stylix
						nixvim.homeModules.nixvim
						nixcord.homeModules.nixcord
						inputs.spicetify-nix.homeManagerModules.default
						{ home.backupFileExtension = "backup"; }
					];
				};
			};
		};
}
