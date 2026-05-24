---
tags: [game, mechanic, rendering]
summary: how a character body, palette, and equipment overlays compose into the on-screen sprite
updated: 2026-05-24
---

- body sprite: single image per `state × direction × frame`, 64×64 px, 8 iso directions (`n, ne, e, se, s, sw, w, nw`)
- body painted with project-defined key colors; each key marks a zone (skin, hair, clothing main, clothing accent, boots, belt, gloves, eyes, ...); zone count is open and grows with character design needs (expect 10-20+ for a fully featured roster)
- key colors are arbitrary; not bound to any external convention (no lpc, no magenta-as-skin)
- `palette.png` is a small swatch image: one column per palette set, one row per key index; shader replaces each body key color with the looked-up value
- skin colour, race, hair, clothing colour, light armor tint — all just different `palette.png` columns; no extra sprites
- equipment split by silhouette impact:
    - body-conformant (clothing, light armor, boots colour, hair) — palette swap only, zero new sprites
    - shape-changing (helmet, cape, shoulders, shield, weapon, bag) — separate overlay sprite, 1 frame × 8 directions, anchored to a body point
- anchor points (`head, right_hand, left_hand, back, belt, ...`) per body frame; overlays snap to them each frame
- anchor data stored as sidecar json `<character>.anchors.json` next to spriteframes; pixel coordinates in 64×64 sprite space, origin top-left
- anchor json schema: `{ "anchors": [name, ...], "states": { state: { direction: [ { anchor: [x, y], ... }, ...frames ] } } }`
- anchor extraction pipeline (primary): marker-pixel method — base frame includes a 1-px unique key colour per anchor (`#FE0001 = head`, `#FE0002 = right_hand`, ...); pixellab rotate/animate preserves single pixels; post-process script reads marker positions per frame into json then repaints the marker pixel with the nearest neighbour to hide it
- anchor extraction fallbacks: pixellab skeleton mode if joint positions are exportable (one anchor per joint); manual anchor marking in aseprite via a script that writes a hotkey-click coordinate to json
- pixellab outputs may have inconsistent per-frame canvas size; pipeline normalises to fixed 64×64 with consistent origin before any anchor extraction
- overlays read `(state, direction, frame)` and look up anchor each tick; render priority flips on rear-facing directions so back-attached items render behind body
- weapon visibility driven by state (hidden in `idle, walk`, shown in `attack` and later combat states), not by its own animation
- attack reuses sub-phases from prior work: `preparation, charging, attacking, returning`; damage triggers on `attacking` phase entry, not on a specific frame index
- animation state list is open-ended; baseline `idle, walk, attack`; add `death, hurt, cast, work` as mechanics require
- shader contract: `bodyshader` spatial material with uniforms `palette_tex` (sampler2d), `palette_column` (int); samples body texel, finds nearest key, replaces with `palette[key, column]`
- asset pipeline: pixellab.ai (tier 1, 320×320 max, downscale to 64×64; `rotate artwork` derives 7 directions from 1; skeleton mode optional for explicit joints) for generation; aseprite for cleanup, palette enforcement, manual anchor fix-ups; godot import script builds spriteframes and anchors json from a folder tree
- folder layout per character: `assets/characters/<name>/<state>/<direction>/frame_<n>.png` + `<name>/anchors.json` + `<name>/palette.png`
- new character cost: one body sheet; reskins (race, npc variants) are free via palette columns; shape-changing equipment items cost 8 sprites each plus their own anchor offset in the overlay definition
- related decisions: see [[game/decisions]]
