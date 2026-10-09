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
      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          konsole = pkgs.callPackage ./packages/konsole.nix { };
          color-schemes = pkgs.callPackage ./packages/color-schemes.nix { inherit gruvbox-plus-kde; };
        in
        {
          inherit konsole color-schemes;
          default = pkgs.symlinkJoin {
            pname = "gruvbox-kde";
            version = "0.2.0";
            paths = [
              konsole
              color-schemes
            ];
            meta = {
              description = "Gruvbox colour schemes for KDE Plasma and Konsole";
              license = [
                lib.licenses.cc0
                lib.licenses.gpl3Only
              ];
              platforms = lib.platforms.all;
            };
          };
        }
      );

      overlays.default = final: _prev: {
        gruvbox-kde = self.packages.${final.stdenv.hostPlatform.system}.default;
      };

      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-tree);
    };
}
