---
tags: [code, files]
summary: table of all source files in rpg-wibe project (path, role)
updated: 2026-05-24
---

- one row per source file in the godot project
- add/patch the row in the same change that adds, renames or deletes the file
- order by path; keep folders contiguous

| path | role |
|---|---|
| `res://project.godot` | godot project file; app name, main scene `test_world.tscn`, input map (`move_up`/`move_down`/`move_left`/`move_right` on WASD and arrows), jolt physics, mobile renderer, nearest texture filter |
| `res://scripts/player.gd` | throwaway prototype player controller; reads screen-relative WASD, rotates input by camera yaw into world XZ, drives `CharacterBody3D.move_and_slide`, picks one of 8 sprite anims from input direction; see [[game/decisions]] |
| `res://scripts/iso_camera.gd` | throwaway prototype orthographic camera; fixed -45° pitch + 45° yaw, lerp-follows a node via `target_path: NodePath`; see [[game/decisions]] |
| `res://scenes/test_world.tscn` | throwaway prototype scene that hosts the walk test |
| `res://assets/textures/dev/grid_dark.png` | placeholder ground texture, 1024×1024 dark grid for visual reference during prototyping |
| `res://assets/characters/test-female-placeholder/idle/<dir>/frame_0.png` | single-frame idle pose per direction, 92×92 px canvas, raw pixellab output |
| `res://assets/characters/test-female-placeholder/walk/<dir>/frame_<0..7>.png` | 8-frame walk cycle per direction, 92×92 px canvas, raw pixellab output |
