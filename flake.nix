{
  description = "Home Manager configuration of WSL";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }: {
      homeConfigurations.wsl = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x64_64-linux;

        modules = [ ./home.nix ];

        extraSpecialArgs = {
          system = "x86_64-linux";
        };
      };

      homeConfigurations.mac = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;

        modules = [ ./home.nix ];

        extraSpecialArgs = {
          system = "aarch64-darwin";
        };
      };
    };
}
