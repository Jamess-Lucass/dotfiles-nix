{ modulesPath, config, lib, pkgs, ... }:

{
  imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
      ./disk-config.nix
  ];

  boot.loader.grub = {
    # no need to set devices, disko will add all devices that have a EF02 partition to the list already
    # devices = [ ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  networking = {
    hostName = "minipc01";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_GB.UTF-8";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.openssh = {
    enable = true;
    # settings.PasswordAuthentication = false;
  };

  security.sudo.wheelNeedsPassword = false;

  users.users.james = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    password = "test"; # Remove this at a later date
  };

  system.stateVersion = "23.11";
}