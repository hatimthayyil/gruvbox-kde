{
  lib,
  symlinkJoin,
  writeTextDir,
  gruvbox-plus-kde,
}:
let
  variants = {
    GruvboxDark = {
      name = "Gruvbox Dark";
      upstream = "GruvboxPlusDark";
      remap = { };
    };
    GruvboxDarkHard = {
      name = "Gruvbox Dark Hard";
      upstream = "GruvboxPlusDark";
      remap."40,40,40" = "29,32,33";
    };
    GruvboxLight = {
      name = "Gruvbox Light";
      upstream = "GruvboxPlusLight";
      remap = { };
    };
    GruvboxLightHard = {
      name = "Gruvbox Light Hard";
      upstream = "GruvboxPlusLight";
      remap."251,241,199" = "249,245,215";
    };
  };

  rewrite =
    id: variant: line:
    let
      entry = builtins.match "([^=]+)=(.*)" line;
      key = builtins.elemAt entry 0;
      value = builtins.elemAt entry 1;
    in
    if entry == null then
      line
    else if key == "Name" then
      "Name=${variant.name}"
    else if key == "ColorScheme" then
      "ColorScheme=${id}"
    else
      "${key}=${variant.remap.${value} or value}";

  scheme =
    id: variant:
    writeTextDir "share/color-schemes/${id}.colors" (
      lib.concatMapStringsSep "\n" (rewrite id variant) (
        lib.splitString "\n" (
          builtins.readFile "${gruvbox-plus-kde}/color-scheme/${variant.upstream}.colors"
        )
      )
    );
in
symlinkJoin {
  pname = "gruvbox-kde-color-schemes";
  version = "0.1.0";
  paths = lib.mapAttrsToList scheme variants;
  meta = {
    description = "Gruvbox colour schemes for KDE applications, derived from Gruvbox Plus";
    homepage = "https://github.com/SylEleuth/gruvbox-plus-kde";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.all;
  };
}
