{
  description = "Home Manager configuration of nixos";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      catppuccin,
      nixvim,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations."alxdb@pm.me" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./alxdb.nix
          ./modules
          ./apps.nix
          ./modules/zed.nix
          catppuccin.homeManagerModules.catppuccin
          nixvim.homeManagerModules.nixvim
        ];

        extraSpecialArgs = {
          username = "alxdb";
          domain = "pm.me";
        };
      };
      homeConfigurations."adavidsonbry@bloomberg.net" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./adavidsonbry.nix
          ./modules
          catppuccin.homeManagerModules.catppuccin
          nixvim.homeManagerModules.nixvim
        ];

        extraSpecialArgs = {
          username = "adavidsonbry";
          domain = "bloomberg.net";
        };
      };
    };
}
