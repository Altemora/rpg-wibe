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
    - godot — coding-solo/godot-mcp, local build at `../tools/godot-mcp/build/index.js`, drives editor and runs scenes via godot cli
    - godot docs mcp — not configured; previous hosted variant removed, local one to be chosen later
