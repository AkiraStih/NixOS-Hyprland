{ pkgs, ... }: {
	programs.waybar.settings.mainBar = {

		# Base
		layer = "top";
		position = "top";
		height = 28;
		spacing = 10;
		ipc = true;

		# Placement
		modules-left = [
			"hyprland/workspaces"
		];
		modules-center = [
			"hyprland/window"
		];
		modules-right = [
			
			"network"
			"custom/spacer"
			"bluetooth"
			"custom/spacer"
			"pulseaudio"
			"custom/spacer"
			"cpu"
			"custom/spacer"
			"memory"
			"custom/spacer"
			"battery"
			"custom/spacer"
			"clock"
			"custom/notification"
			
		];

		# Modules

		"custom/spacer" = {
			tooltip = false;
			format = "|";
		};

		"pulseaudio" = {
			format = "{volume}% {icon} ";
			format-bluetooth = "{volume}% {icon} ";
			format-muted = "";
			scroll-step = 1;
			on-click = "pwvucontrol";
			format-icons = {
				headphone = "";
				hands-free = "";
				headset = "";
				phone = "";
				phone-muted = "";
				portable = "";
				car = "";
				default = [ "" "" ];
			};
		};

		# Hyprland modules

		"hyprland/workspaces" = {
			format = "{name}";
			persistent-workspaces."*" = 9; 
		};

		# Base modules
		"clock" = {
			interval = 60;
			format = "{:%d/%m/%y %H:%M}";
		};

		"network" = {
		  format-wifi = "  {essid} ({signalStrength}%)"; # Иконка, имя сети, сила сигнала
		  format-ethernet = "󰈀 {ifname}"; # Иконка для проводного подключения
		  format-disconnected = "󰖪"; # Иконка и текст, когда нет подключения
		  tooltip-format = "{ifname} via {gwaddr} "; # Подсказка при наведении
		  on-click = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor"; # Открывает GUI для настройки сетей
			};

			"bluetooth" = {
			  "format": "";
			  "format-connected": "";
			  "format-disabled": "󰂲"; 
			  "on-click": "${pkgs.blueman}/bin/blueman-manager";
			  "tooltip-format": "{device_alias}";
			  "tooltip-format-connected": "{device_alias} ({device_battery_percentage}%)" ;
			};
		# Hardware

		"cpu" = {
			interval = 10;
			format = "{usage}%  ";
		};

		"memory" = {
			interval = 30;
			format = "{percentage}%  ";
		};

		# Notificaions

		"custom/notification" = {
			tooltip = false;
			format = "{} {icon} ";
			format-icons = {
				notification = "<span foreground='red'><sup></sup></span>";
				none = "";
				dnd-notification = "<span foreground='red'><sup></sup></span>";
				dnd-none = "";
				inhibited-notification = "<span foreground='red'><sup></sup></span>";
				inhibited-none = "";
				dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
				dnd-inhibited-none = "";
			};
			return-type = "json";
			exec-if = "which swaync-client";
			exec = "${pkgs.swaynotificationcenter}/bin/swaync-client -swb";
			on-click = "${pkgs.swaynotificationcenter}/bin/swaync-client -t -sw";
			on-click-right = "${pkgs.swaynotificationcenter}/bin/swaync-client -d -sw";
			escape = true;
		};
	};
}
