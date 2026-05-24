---
tags:
  - tech
  - stack
summary: engine, renderer, physics, world constants, art tooling
updated: 2026-05-24
---

- engine: godot 4.6
- renderer: mobile
- physics 3d: jolt
- windows graphics driver: d3d12
- language: gdscript (default)
- rendering approach: 3d scene + sprite3d billboards + pixel art textures
- camera: isometric, fixed, -45° pitch + 45° yaw
- world constants:
    - grid cell: 1×1×1 godot unit (1 unit ≈ 1m)
    - floor height: 1 unit
    - character size: ~0.8w × 1.8h units (≈ 2 cells tall)
    - tile texture: 32×32 px
- art tooling: aseprite for hand-drawn pixel art, pixellab.ai for ai-assisted pixel generation
- art rejected: midjourney, dall-e — weak for pixel art
- plugins: none yet
- platform targets: tbd
- agent tooling (mcp servers, configured in `.mcp.json`):
    - obsidian — vault access via local rest api on `127.0.0.1:27123`
    - godot — coding-solo/godot-mcp, drives editor and runs scenes via godot cli
        - lives at `tools/godot-mcp/` (repo root, gitignored — per-machine build)
        - install: `git clone https://github.com/Coding-Solo/godot-mcp.git tools/godot-mcp && cd tools/godot-mcp && npm install && npm run build`
        - entry: `tools/godot-mcp/build/index.js` (run via `node`)
        - env `GODOT_PATH` must point to the godot executable on this machine
        - requires node 18+ and a local godot 4.x install
    - godot-docs — tkmct/godot-doc-mcp, serves godot api docs from bundled xml class files
        - lives at `tools/godot-doc-mcp/` (repo root, gitignored — per-machine build)
        - install: `git clone https://github.com/tkmct/godot-doc-mcp.git tools/godot-doc-mcp && cd tools/godot-doc-mcp && npx --yes pnpm install`
        - entry: `node --import <tsx-loader-file-url> tools/godot-doc-mcp/server/src/cli.ts` — uses absolute paths so it works regardless of client `cwd` support
        - on windows the tsx loader must be passed as a `file:///` url (not a raw drive-letter path) due to esm url-scheme requirements
        - env `GODOT_DOC_DIR` set to absolute path of `tools/godot-doc-mcp/doc/classes`
        - bundled docs at `tools/godot-doc-mcp/doc/classes/` (~892 xml files); to refresh: `Godot --doctool ./doc/classes --headless`
        - requires node 20+; pnpm via npx (no global install needed)
