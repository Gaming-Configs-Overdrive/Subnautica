# Subnautica

[English](README.md)

Das [Spielmanifest](game.yml) beschreibt das erste [Subnautica auf Steam](https://store.steampowered.com/app/264710/Subnautica/) (App-ID `264710`). Die lokale Windows-Installation enthält `Subnautica.exe`. Steam meldet Build `20241558`.

In der Installation gab es weder einen BepInEx- noch einen QMods-Ordner. In den geprüften Mod-Manager-Ordnern und Downloads fanden sich keine Subnautica-Mods. Es lag kein Loader-Protokoll vor, das aktive Plugins belegt. Die Modliste im Manifest ist leer.

## Mods unter Windows einrichten

1. Öffne in Steam **Subnautica → Verwalten → Lokale Dateien durchsuchen**. Beende das Spiel und folge der [Windows-Anleitung für das BepInEx-Pack](https://github.com/toebeann/BepInEx.Subnautica#manual-installation).
2. Installiere die Abhängigkeiten deiner ausgewählten Mods. Falls ein Mod Nautilus voraussetzt, verwende das Release für das erste Subnautica und deinen Steam-Zweig. Siehe die [Nautilus-Installationsanleitung](https://github.com/SubnauticaModding/Nautilus#installation).
3. Installiere jeden Mod nach Anleitung des Autors. BepInEx-Plugins kommen üblicherweise nach `BepInEx/plugins/`. Starte das Spiel über Steam und prüfe in `BepInEx/LogOutput.log` die geladenen Plugins und etwaige Fehler, bevor du deinen Hauptspielstand öffnest.

## Optionaler Einstieg in Vanilla+

Quick Slots Plus erweitert die Schnellleiste und setzt BepInEx und Nautilus voraus. Die Kompatibilität mit Steam-Build `20241558` steht noch zur Prüfung aus. [Quick Slots Plus (BepInEx)](https://www.nexusmods.com/subnautica/mods/984?tab=description)

## Modliste erzeugen

Führe diese Befehle mit Node.js 24 aus.

```sh
npm ci
npm run validate
npm test
npm run build
```

Der Build schreibt die Modliste nach `dist/MODS.md` und legt das Manifest in `dist/fullrelease.zip` ab. Dieses Starter-Setup enthält keine Mod- oder Konfigurationsdateien.
