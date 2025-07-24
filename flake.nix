{
  description = "NixOS + Hyprland + Home Manager + NVIDIA";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs @ { nixpkgs, home-manager, hyprland, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [
            hyprland.overlays.default
          ];
        };
      in {
        formatter = pkgs.nixpkgs-fmt;
      }) // {
        nixosConfigurations.default = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          specialArgs = {
            inherit inputs;
            inherit (inputs) hyprland;
          };

          modules = [
            # Aktiviert unfreie Pakete im Systemkontext
            ({ config, pkgs, ... }: {
              nixpkgs.config.allowUnfree = true;
            })

            ./hosts/default.nix

            # Home Manager Einbindung
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.jn = import ./home/jn.nix;
            }
          ];
        };
      };
}