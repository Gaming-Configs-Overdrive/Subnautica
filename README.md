# Subnautica

[Deutsch](README.de.md)

Vanilla+ for the original [Subnautica on Steam](https://store.steampowered.com/app/264710/Subnautica/) on Windows, targeting build `20241558`. The [game manifest](game.yml) pins the four upstream downloads and their SHA-256 hashes. The downloads and file layout have been verified. The pack still needs an in-game check on this build.

| Component                                                                                                 | Version           | Purpose                                          |
| --------------------------------------------------------------------------------------------------------- | ----------------- | ------------------------------------------------ |
| [Tobey's BepInEx Pack](https://github.com/toebeann/BepInEx.Subnautica/releases/tag/v5.4.23-pack.3.1.1)    | 5.4.23-pack.3.1.1 | Loads Windows plugins.                           |
| [Nautilus](https://github.com/SubnauticaModding/Nautilus/releases/tag/1.0.0-pre.57)                       | 1.0.0-pre.57      | Modding library required by Quick Slots Plus.    |
| [Quick Slots Plus](https://github.com/celvro/QuickSlotsPlus/releases/tag/v3.2.0)                          | 3.2.0             | Adds configurable hotbar slots and key bindings. |
| [Blueprint Search Bar](https://github.com/32Kallies/SubnauticaMods/releases/tag/BlueprintSearchBar/1.1.0) | 1.1.0             | Filters blueprints in the PDA.                   |

## Install on Windows

Use PowerShell from the unpacked release folder with a `gco-install.exe` that supports `--mod-payloads`. Close the game before installing. If the game already has mods, check for overlapping BepInEx or plugin installations before applying the pack.

1. Download, verify and stage the files in a new `mod-payloads` folder. [Staging script](docs/prepare-mods.ps1)

   ```powershell
   .\docs\prepare-mods.ps1
   ```

2. Preview the files the installer will write to the Steam game folder.

   ```powershell
   .\gco-install.exe install --manifest .\game.yml --mod-payloads .\mod-payloads --dry-run
   ```

3. Apply the pack with backups.

   ```powershell
   .\gco-install.exe install --manifest .\game.yml --mod-payloads .\mod-payloads
   ```

4. Launch Subnautica through Steam. Check `BepInEx/LogOutput.log` for the three plugins. In a test save, try an extra quick slot and search for a known blueprint in the PDA.

To undo the installation, close the game and run `.\gco-install.exe restore --manifest .\game.yml`.

### Staging layout

Each mod ID sits directly under `mod-payloads/`. Its files use paths relative to the folder containing `Subnautica.exe`.

| Mod ID                 | Staged paths under the mod ID                                                                                  |
| ---------------------- | -------------------------------------------------------------------------------------------------------------- |
| `bepinex`              | `BepInEx/`, `.doorstop_version`, `doorstop_config.ini`, `steam_appid.txt`, `winhttp.dll` from the archive root |
| `nautilus`             | `BepInEx/plugins/Nautilus/` from `plugins/Nautilus/`                                                           |
| `quick-slots-plus`     | `BepInEx/plugins/QuickSlotsPlus/` as shipped                                                                   |
| `blueprint-search-bar` | `BepInEx/plugins/BlueprintSearchBar/` from `plugins/BlueprintSearchBar/`                                       |

## Build the release

Run these commands with Node.js 24.

```sh
npm ci
npm run validate
npm test
npm run format:check -- --end-of-line auto
npm run build
```

The build writes `dist/MODS.md` with the upstream links and includes the manifest and staging script in `dist/fullrelease.zip`. Mod binaries are downloaded directly from the authors at setup time.
