self:
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.gruvbox-kde;
  scheme = polarity: "Gruvbox${polarity}${lib.optionalString (cfg.contrast == "hard") "Hard"}";
  profile = polarity: "Gruvbox ${polarity}";
in
{
  options.gruvbox-kde = {
    contrast = lib.mkOption {
      type = lib.types.enum [
        "standard"
        "hard"
      ];
      default = "standard";
      description = "Gruvbox contrast variant.";
    };
    konsole.enable = lib.mkEnableOption "gruvbox Konsole profiles that follow the system light/dark setting";
    plasma.enable = lib.mkEnableOption "gruvbox KDE colour scheme and Gruvbox Plus icons";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.konsole.enable {
      programs.konsole = {
        enable = true;
        defaultProfile = lib.mkDefault (profile "Light");
        customColorSchemes = lib.genAttrs (map scheme [
          "Light"
          "Dark"
        ]) (name: ../konsole + "/${name}.colorscheme");
        profiles = lib.genAttrs' [ "Light" "Dark" ] (
          polarity:
          lib.nameValuePair (profile polarity) {
            colorScheme = scheme polarity;
            font.name = lib.mkDefault "Hack";
          }
        );
        extraConfig.LightDarkTheme = {
          SyncProfileWithSystemTheme = true;
          LightThemeProfile = profile "Light";
          DarkThemeProfile = profile "Dark";
        };
      };
    })
    (lib.mkIf cfg.plasma.enable {
      home.packages = [
        self.packages.${pkgs.stdenv.hostPlatform.system}.color-schemes
        pkgs.gruvbox-plus-icons
      ];
      programs.plasma.workspace = {
        colorScheme = scheme "Light";
        iconTheme = "Gruvbox-Plus-Dark";
      };
    })
  ];
}
