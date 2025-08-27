{ config, pkgs, ... }:
{
programs.nekoray = {
    enable = true; # Включаем саму программу
    tunMode.enable = true; # Включаем режим TUN с повышенными правами
  };
}
