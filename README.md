# gruvbox-kde

[Gruvbox](https://github.com/morhetz/gruvbox) colour schemes for KDE Plasma and Konsole, in hard and standard contrast, light and dark.

| Scheme | Background |
| --- | --- |
| `GruvboxDarkHard` | `bg0_h` `#1d2021` |
| `GruvboxDark` | `bg0` `#282828` |
| `GruvboxLightHard` | `bg0_h` `#f9f5d7` |
| `GruvboxLight` | `bg0` `#fbf1c7` |

Each name exists as a Konsole scheme (`konsole/*.colorscheme`) and a KDE colour scheme (`share/color-schemes/*.colors` in the `default` package).

## Konsole

Normal colours use the gruvbox neutral palette. Intense colours use bright on dark and faded on light, the same mapping gruvbox uses for terminals. Faint colours swap the two. The variants differ only in background.

## KDE colour schemes

Built from the `GruvboxPlusDark` and `GruvboxPlusLight` schemes of [Gruvbox Plus KDE](https://github.com/SylEleuth/gruvbox-plus-kde), fetched as a flake input. `packages/color-schemes.nix` keeps upstream colours. The hard variants only replace `bg0` with `bg0_h`.

For icons, [Gruvbox Plus Icon Pack](https://github.com/SylEleuth/gruvbox-plus-icon-pack) (`gruvbox-plus-icons` in nixpkgs) fits. Use `Gruvbox-Plus-Dark` with either polarity: its symbolic icons follow the colour scheme.

## Install

With home-manager and [plasma-manager](https://github.com/nix-community/plasma-manager):

```nix
inputs.gruvbox-kde.url = "github:hatimthayyil/gruvbox-kde";

imports = [ inputs.gruvbox-kde.homeModules.default ];

gruvbox-kde = {
  contrast = "hard"; # or "standard"
  konsole.enable = true; # profiles "Gruvbox Light" and "Gruvbox Dark", following the system light/dark setting
  plasma.enable = true; # KDE colour scheme and Gruvbox-Plus-Dark icons
};
```

The `default` package holds the KDE colour schemes alone.

Without Nix, copy `konsole/*.colorscheme` to `~/.local/share/konsole/`. The KDE colour schemes are generated, so build them with `nix build`.

## Licence

This repository is [CC0 1.0](LICENSE). The gruvbox palette is from morhetz/gruvbox (MIT).

The KDE colour schemes are derived from Gruvbox Plus KDE and are GPL-3.0. This repository contains none of its files: the build fetches them, and the `default` package carries the GPL-3.0 licence.
