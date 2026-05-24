---
tags: [code, scene, prototype]
summary: throwaway prototype scene that hosts the walk test on a flat ground
updated: 2026-05-24
---

- name: `test_world`
- declared in: `res://scenes/test_world.tscn`
- root node: `Node3D` (`TestWorld`)
- attached script: none
- status: throwaway prototype; replaceable per [[game/decisions]] and [[roadmap]]
- children:
    - `WorldEnvironment` — procedural sky + ambient light
    - `DirectionalLight3D` — key light, shadows disabled (prototype)
    - `Ground` (`MeshInstance3D`) — 40×40 `PlaneMesh`, dev grid texture tiled 10×10
    - `Player` (`CharacterBody3D`) — attaches `Player` script ([[code/classes/player|Player]])
        - `AnimatedSprite3D` — y-billboard, `pixel_size = 0.03125`, alpha-cut discard, shadow off
        - `FootMarker` (`MeshInstance3D`) — 0.9×0.9 quad lying on the ground for positional reference
        - `CollisionShape3D` — capsule, 0.4 radius × 1.8 height
    - `IsoCamera` (`Camera3D`) — attaches `IsoCamera` script ([[code/classes/iso_camera|IsoCamera]]); `target_path = ../Player`, `view_size = 10`
