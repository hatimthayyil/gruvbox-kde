{
  description = "Gruvbox colour schemes for Konsole";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
    in
    {
      packages = forAllSystems (system: {
        default = nixpkgs.legacyPackages.${system}.stdenvNoCC.mkDerivation {
          pname = "gruvbox-konsole";
          version = "0.1.0";
          src = ./konsole;
          installPhase = ''
            install -Dm644 -t $out/share/konsole *.colorscheme
          '';
          meta = {
            description = "Gruvbox colour schemes for Konsole";
            license = nixpkgs.lib.licenses.mit;
            platforms = nixpkgs.lib.platforms.all;
          };
        };
      });

      overlays.default = final: _prev: {
        gruvbox-konsole = self.packages.${final.stdenv.hostPlatform.system}.default;
      };

      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-tree);
    };
}
