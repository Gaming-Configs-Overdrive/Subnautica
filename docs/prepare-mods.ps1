#Requires -Version 5.1

[CmdletBinding()]
param(
    [Parameter()]
    [string]$OutputDirectory = '.\mod-payloads'
)

$ErrorActionPreference = 'Stop'

# These pins match game.yml. Paths below select only the Windows Steam payload.
$releases = @(
    @{
        Id = 'bepinex'
        Url = 'https://github.com/toebeann/BepInEx.Subnautica/releases/download/v5.4.23-pack.3.1.1/Tobey.s.BepInEx.Pack.for.Subnautica.zip'
        Sha256 = '21a1fd6ec22253a6cf05ccf1f6407f6055c95971a7dda7545b33481069a4dd3e'
        ArchivePaths = @('BepInEx', '.doorstop_version', 'doorstop_config.ini', 'steam_appid.txt', 'winhttp.dll')
        GamePath = '.'
    }
    @{
        Id = 'nautilus'
        Url = 'https://github.com/SubnauticaModding/Nautilus/releases/download/1.0.0-pre.57/Nautilus_SN.STABLE_1.0.0.57.zip'
        Sha256 = '72460dea2c669838d0f05f882fbeca6c82891d39507f1a27f46618d100cbc82a'
        ArchivePaths = @('plugins')
        GamePath = 'BepInEx'
    }
    @{
        Id = 'quick-slots-plus'
        Url = 'https://github.com/celvro/QuickSlotsPlus/releases/download/v3.2.0/QuickSlotsPlus-3.2.0.zip'
        Sha256 = '9624a5f2bf8553444c33c45a49766b5629aa661b279b3f9dae1d65da593ba829'
        ArchivePaths = @('BepInEx')
        GamePath = '.'
    }
    @{
        Id = 'blueprint-search-bar'
        Url = 'https://github.com/32Kallies/SubnauticaMods/releases/download/BlueprintSearchBar/1.1.0/BlueprintSearchBar-1.1.0.zip'
        Sha256 = 'aab28bc113c592519d4f8a1b76bb1ede3a671c15343d0d5ab011d26b05bcdb52'
        ArchivePaths = @('plugins')
        GamePath = 'BepInEx'
    }
)

$destination = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($OutputDirectory)
if (Test-Path -LiteralPath $destination) {
    throw "The output path already exists. Choose a new directory: $destination"
}

$parent = Split-Path -LiteralPath $destination
$working = Join-Path $parent ".subnautica-mods-$([guid]::NewGuid())"
New-Item -ItemType Directory -Path $working | Out-Null
try {
    $staged = Join-Path $working 'payloads'
    foreach ($release in $releases) {
        $id = $release.Id
        Write-Host "Downloading and verifying $id"
        $archive = Join-Path $working "$id.zip"
        Invoke-WebRequest -Uri $release.Url -OutFile $archive -UseBasicParsing
        $hash = (Get-FileHash -LiteralPath $archive -Algorithm SHA256).Hash
        if ($hash -ine $release.Sha256) {
            throw "SHA-256 mismatch for $id (expected $($release.Sha256), received $hash)."
        }

        $expanded = Join-Path $working $id
        Expand-Archive -LiteralPath $archive -DestinationPath $expanded
        $target = Join-Path (Join-Path $staged $id) $release.GamePath
        New-Item -ItemType Directory -Path $target -Force | Out-Null
        foreach ($item in $release.ArchivePaths) {
            $source = Join-Path $expanded $item
            Copy-Item -LiteralPath $source -Destination $target -Recurse -Force
        }
    }

    [IO.Directory]::Move($staged, $destination)
    Write-Host "Prepared mod payloads in $destination"
}
finally {
    Remove-Item -LiteralPath $working -Recurse -Force
}
