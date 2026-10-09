{ lib, stdenvNoCC }:
stdenvNoCC.mkDerivation {
  pname = "gruvbox-konsole";
  version = "0.2.0";
  src = ../konsole;
  installPhase = ''
    install -Dm644 -t $out/share/konsole *.colorscheme
  '';
  meta = {
    description = "Gruvbox colour schemes for Konsole";
    license = lib.licenses.cc0;
    platforms = lib.platforms.all;
  };
}
