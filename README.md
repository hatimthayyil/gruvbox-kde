# gruvbox-kde

[Gruvbox](https://github.com/morhetz/gruvbox) colour schemes for KDE Plasma and Konsole, in hard and standard contrast, light and dark.

| Scheme | Background |
| --- | --- |
| `GruvboxDarkHard` | `bg0_h` `#1d2021` |
| `GruvboxDark` | `bg0` `#282828` |
| `GruvboxLightHard` | `bg0_h` `#f9f5d7` |
| `GruvboxLight` | `bg0` `#fbf1c7` |

Each name exists as a Konsole scheme (`share/konsole/*.colorscheme`) and a KDE colour scheme (`share/color-schemes/*.colors`).

## Konsole

Normal colours use the gruvbox neutral palette. Intense colours use bright on dark and faded on light, the same mapping gruvbox uses for terminals. Faint colours swap the two. The variants differ only in background.

## KDE colour schemes

Built from the `GruvboxPlusDark` and `GruvboxPlusLight` schemes of [Gruvbox Plus KDE](https://github.com/SylEleuth/gruvbox-plus-kde), fetched as a flake input. `packages/color-schemes.nix` keeps upstream colours. The hard variants only replace `bg0` with `bg0_h`.

For icons, [Gruvbox Plus Icon Pack](https://github.com/SylEleuth/gruvbox-plus-icon-pack) (`gruvbox-plus-icons` in nixpkgs) fits. Use `Gruvbox-Plus-Dark` with either polarity: its symbolic icons follow the colour scheme.

## Install

With Nix:

```nix
inputs.gruvbox-kde.url = "github:hatimthayyil/gruvbox-kde";

home.packages = [ inputs.gruvbox-kde.packages.${pkgs.stdenv.hostPlatform.system}.default ];
```

Packages: `konsole`, `color-schemes`, and `default` with both. `overlays.default` adds `pkgs.gruvbox-kde`. Plasma and Konsole find the files through `XDG_DATA_DIRS`.

Without Nix, copy `konsole/*.colorscheme` to `~/.local/share/konsole/`. The KDE colour schemes are generated, so build them with `nix build .#color-schemes`.

## Licence

This repository is [CC0 1.0](LICENSE). The gruvbox palette is from morhetz/gruvbox (MIT).

The KDE colour schemes are derived from Gruvbox Plus KDE and are GPL-3.0. This repository contains none of its files: the build fetches them, and the `color-schemes` package carries the GPL-3.0 licence.
