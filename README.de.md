# Subnautica

[English](README.md)

Vanilla+ für das erste [Subnautica auf Steam](https://store.steampowered.com/app/264710/Subnautica/) unter Windows, ausgelegt auf Build `20241558`. Das [Spielmanifest](game.yml) hält die vier Original-Downloads und ihre SHA-256-Prüfsummen fest. Downloads und Dateipfade sind geprüft. Der Test im Spiel steht für diesen Build noch aus.

| Komponente                                                                                                | Version           | Zweck                                                                       |
| --------------------------------------------------------------------------------------------------------- | ----------------- | --------------------------------------------------------------------------- |
| [Tobeys BepInEx-Pack](https://github.com/toebeann/BepInEx.Subnautica/releases/tag/v5.4.23-pack.3.1.1)     | 5.4.23-pack.3.1.1 | Lädt Plugins unter Windows.                                                 |
| [Nautilus](https://github.com/SubnauticaModding/Nautilus/releases/tag/1.0.0-pre.57)                       | 1.0.0-pre.57      | Modding-Bibliothek für Quick Slots Plus.                                    |
| [Quick Slots Plus](https://github.com/celvro/QuickSlotsPlus/releases/tag/v3.2.0)                          | 3.2.0             | Erweitert die Schnellleiste um konfigurierbare Plätze und Tastenbelegungen. |
| [Blueprint Search Bar](https://github.com/32Kallies/SubnauticaMods/releases/tag/BlueprintSearchBar/1.1.0) | 1.1.0             | Filtert Blaupausen im PDA.                                                  |

## Unter Windows installieren

Öffne PowerShell im entpackten Release-Ordner und nutze eine `gco-install.exe`, die `--mod-payloads` unterstützt. Beende das Spiel vor der Installation. Falls bereits Mods installiert sind, prüfe vor dem Anwenden, ob dieselben Plugins oder BepInEx-Dateien vorhanden sind.

1. Lade die Dateien herunter, prüfe sie und lege sie im neuen Ordner `mod-payloads` bereit. [Vorbereitungsskript](docs/prepare-mods.ps1)

   ```powershell
   .\docs\prepare-mods.ps1
   ```

2. Prüfe in der Vorschau, welche Dateien der Installer in den Steam-Spielordner schreibt.

   ```powershell
   .\gco-install.exe install --manifest .\game.yml --mod-payloads .\mod-payloads --dry-run
   ```

3. Installiere das Paket mit Sicherung der betroffenen Dateien.

   ```powershell
   .\gco-install.exe install --manifest .\game.yml --mod-payloads .\mod-payloads
   ```

4. Starte Subnautica über Steam. Prüfe in `BepInEx/LogOutput.log`, ob die drei Plugins geladen wurden. Probiere in einem Testspielstand einen zusätzlichen Schnellleistenplatz aus und suche im PDA eine bekannte Blaupause.

Zum Rückgängigmachen schließe das Spiel und führe `.\gco-install.exe restore --manifest .\game.yml` aus.

### Ordnerstruktur für die Installation

Jede Mod-ID ist ein Ordner direkt unter `mod-payloads/`. Darin liegen die Dateien relativ zum Ordner, der `Subnautica.exe` enthält.

| Mod-ID                 | Pfade im Ordner der Mod-ID                                                                                            |
| ---------------------- | --------------------------------------------------------------------------------------------------------------------- |
| `bepinex`              | `BepInEx/`, `.doorstop_version`, `doorstop_config.ini`, `steam_appid.txt`, `winhttp.dll` aus dem Hauptordner des ZIPs |
| `nautilus`             | `BepInEx/plugins/Nautilus/` aus `plugins/Nautilus/`                                                                   |
| `quick-slots-plus`     | `BepInEx/plugins/QuickSlotsPlus/` wie im ZIP                                                                          |
| `blueprint-search-bar` | `BepInEx/plugins/BlueprintSearchBar/` aus `plugins/BlueprintSearchBar/`                                               |

## Release bauen

Führe diese Befehle mit Node.js 24 aus.

```sh
npm ci
npm run validate
npm test
npm run format:check -- --end-of-line auto
npm run build
```

Der Build schreibt die Modliste mit Original-Links nach `dist/MODS.md` und legt das Manifest und das Vorbereitungsskript in `dist/fullrelease.zip` ab. Die Mod-Dateien werden bei der Vorbereitung direkt von den Autoren heruntergeladen.
