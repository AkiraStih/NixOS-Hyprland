{ config, pkgs, lib, ... }:

{
  # Создаем нашу собственную опцию, чтобы не хранить UUID внутри модуля
  options.bogdan.t480.rootfsUUID = lib.mkOption {
    type = lib.types.str; # Тип опции - строка
    default = ""; # Значение по умолчанию
    description = "The UUID of the root filesystem for resumeDevice.";
  };

  # А теперь сама конфигурация, которая будет применяться
  config = {
    # 1. Главный фикс для сна
    boot.kernelParams = [ "acpi_osi=!\" acpi_osi=Windows 2020\"" ];

    # 2. Настройка Swap
    swapDevices = [
      { device = "/swapfile"; size = 16 * 1024; }
    ];

    # 3. Указываем ядру, откуда просыпаться, ИСПОЛЬЗУЯ нашу новую опцию!
    boot.resumeDevice = "/dev/disk/by-uuid/${config.bogdan.t480.rootfsUUID}";
  };
}
