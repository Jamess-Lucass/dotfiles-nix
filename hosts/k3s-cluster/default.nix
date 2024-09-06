{ modulesPath, config, lib, pkgs, ... }:

{
  imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
      (modulesPath + "/profiles/qemu-guest.nix")
      ./disk-config.nix
  ];

  boot.loader.grub = {
    # no need to set devices, disko will add all devices that have a EF02 partition to the list already
    # devices = [ ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  # networking = {
  #   hostName = "minipc01";
  # };

  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_GB.UTF-8";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

  security.sudo.wheelNeedsPassword = false;

  users.users.james = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICu21cvLmuaWIukVd2Z2m0jxTNFuEW5kc4HaK7HWirHX james@James"
    ];
  };

  system.stateVersion = "23.11";
}