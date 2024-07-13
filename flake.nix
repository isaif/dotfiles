{
  description = "my flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    stylix.url = "github:danth/stylix";
  };

  outputs = {self, nixpkgs, home-manager, stylix, ... }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      overlays = [
        inputs.neovim-nightly-overlay.overlays.default
      ];
    in {

    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./nixos/configuration.nix
          ./awesome.nix
        ];
      };
    };

    homeConfigurations = {
      "saif@nixos" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home-manager/home.nix
          stylix.homeManagerModules.stylix
          {
              nixpkgs.overlays = overlays;
          }
        ];
      };
    };
  };
}
