{
  description = "Gruvbox colour schemes for KDE Plasma and Konsole";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    gruvbox-plus-kde = {
      url = "github:SylEleuth/gruvbox-plus-kde";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      gruvbox-plus-kde,
    }:
    let
      inherit (nixpkgs) lib;
      forAllSystems = lib.genAttrs lib.systems.flakeExposed;
    in
    {
      packages = forAllSystems (system: rec {
        color-schemes = nixpkgs.legacyPackages.${system}.callPackage ./packages/color-schemes.nix {
          inherit gruvbox-plus-kde;
        };
        default = color-schemes;
      });

      homeModules.default = import ./modules/home-manager.nix self;

      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-tree);
    };
}
