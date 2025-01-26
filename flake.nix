{
  description = "jn.nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/laptop.nix
          ./modules/common.nix
          home-manager.nixosModules.home-manager
        ];
      };

      desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/desktop.nix
          ./modules/common.nix
          home-manager.nixosModules.home-manager
        ];
      };
    };

    homeConfigurations = {
      "jn@laptop" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [ ./home/laptop-home.nix ];
      };

      "jn@desktop" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [ ./home/desktop-home.nix ];
      };
    };

    packages = {
      x86_64-linux = {
        laptop = self.nixosConfigurations.laptop.config.system.build.toplevel;
        desktop = self.nixosConfigurations.desktop.config.system.build.toplevel;
      };
    };
  };
}