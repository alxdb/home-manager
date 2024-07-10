{
  description = "Home Manager configuration of nixos";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      catppuccin,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations.alxdb = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./apps.nix
          ./home.nix
          ./modules
          catppuccin.homeManagerModules.catppuccin
        ];
      };
    };
}
