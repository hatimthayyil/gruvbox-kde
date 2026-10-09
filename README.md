# gruvbox-konsole

[Gruvbox](https://github.com/morhetz/gruvbox) colour schemes for KDE Konsole:

- `GruvboxDarkHard`
- `GruvboxLightHard`

Normal colours use the gruvbox neutral palette. Intense colours use bright on dark and faded on light, the same mapping gruvbox uses for terminals. Faint colours swap the two.

## Install

Copy `konsole/*.colorscheme` to `~/.local/share/konsole/`, then pick the scheme under Settings > Edit Current Profile > Appearance.

With Nix, the flake's default package installs the schemes to `share/konsole`:

```nix
inputs.gruvbox-konsole.url = "github:hatimthayyil/gruvbox-konsole";

home.packages = [ inputs.gruvbox-konsole.packages.${pkgs.stdenv.hostPlatform.system}.default ];
```

Konsole finds them through `XDG_DATA_DIRS`. `overlays.default` adds `pkgs.gruvbox-konsole`.

## Licence

MIT. The palette is from morhetz/gruvbox, also MIT.
