import assert from 'node:assert/strict'
import fs from 'node:fs'
import { test } from 'node:test'
import YAML from 'yaml'

test('the Windows staging script downloads exactly the manifest pins', () => {
  const manifest = YAML.parse(
    fs.readFileSync(new URL('../game.yml', import.meta.url), 'utf8')
  )
  const script = fs.readFileSync(
    new URL('../docs/prepare-mods.ps1', import.meta.url),
    'utf8'
  )
  const pins = Array.from(
    script.matchAll(
      /Id = '([^']+)'\s+Url = '([^']+)'\s+Sha256 = '([a-f0-9]{64})'/g
    ),
    ([, id, url, sha256]) => ({ id, url, sha256 })
  )
  assert.deepEqual(
    pins,
    manifest.mods.items
      .filter((mod) => mod.distribute === 'link')
      .map(({ id, source, sha256 }) => ({ id, url: source.url, sha256 }))
  )
})
