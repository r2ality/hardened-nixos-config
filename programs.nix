{ config, pkgs, ... }:

{
  programs.niri.enable = true;

  # Home manager
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "hm-bak";

  # USB Stuff
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # Display manager
  services.displayManager.ly.enable = true;

  # Enable basic desktop services
  services.dbus.enable = true;
  programs.dconf.enable = true;

  # Sound
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };
}

