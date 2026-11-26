# Subnautica

[Deutsch](README.de.md)

The [game manifest](game.yml) describes the original [Subnautica on Steam](https://store.steampowered.com/app/264710/Subnautica/) (app ID `264710`). The local Windows installation contains `Subnautica.exe` and Steam reports build `20241558`.

The installation had no BepInEx or QMods folder. The mod-manager locations and downloads checked contained no Subnautica mods, and no loader log was available to confirm active plugins. The manifest starts with an empty mod list.

## Set up mods on Windows

1. In Steam, open **Subnautica → Manage → Browse local files** to find the folder containing `Subnautica.exe`. With the game closed, follow the [BepInEx pack's Windows instructions](https://github.com/toebeann/BepInEx.Subnautica#manual-installation).
2. Install the dependencies for your chosen mods. If a mod requires Nautilus, use the release for the original Subnautica and your Steam branch. See the [Nautilus installation guide](https://github.com/SubnauticaModding/Nautilus#installation).
3. Install each mod according to its author's instructions. BepInEx plugins usually go into `BepInEx/plugins/`. Start the game through Steam and check `BepInEx/LogOutput.log` for plugin loading and errors before opening your main save.

## Optional Vanilla+ starting point

Quick Slots Plus adds more hotbar slots and requires BepInEx and Nautilus. Compatibility with Steam build `20241558` remains untested. [Quick Slots Plus (BepInEx)](https://www.nexusmods.com/subnautica/mods/984?tab=description)

## Build the inventory

Run these commands with Node.js 24.

```sh
npm ci
npm run validate
npm test
npm run build
```

The build writes `dist/MODS.md` and includes the manifest in `dist/fullrelease.zip`. This starter contains no mod or config payloads.
