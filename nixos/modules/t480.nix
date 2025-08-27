# ~/nixhypr/nixos/modules/hardware/t480.nix

{ config, pkgs, ... }:

{
  # Вся конфигурация просто переносится сюда
  boot.kernelParams = [ "acpi_osi=!\" acpi_osi=Windows 2020\"" ];

  swapDevices = [
    { device = "/swapfile"; size = 16 * 1024; }
  ];

  boot.resumeDevice = "/dev/disk/by-uuid/e8aea24e-029d-4e5e-b6f9-68276d452023"; # <--- UUID остается здесь
}
