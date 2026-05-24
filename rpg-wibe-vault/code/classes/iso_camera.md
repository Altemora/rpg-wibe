---
tags: [code, class, prototype]
summary: throwaway prototype orthographic camera; fixed iso angle, lerp-follows a target node
updated: 2026-05-24
---

- name: `IsoCamera`
- declared in: `res://scripts/iso_camera.gd`
- extends: `Camera3D`
- status: throwaway prototype; replaceable per [[game/decisions]] and [[roadmap]]
- responsibility:
    - project orthographic with fixed -45° pitch + 45° yaw
    - lerp-follow a target node by `NodePath`
- constants:
    - `PITCH_DEG = 45.0`
    - `YAW_DEG = 45.0`
    - `DISTANCE = 20.0`
- exported parameters:
    - `target_path: NodePath` — node to follow
    - `view_size: float = 8.0` — orthographic view size in world units
    - `follow_speed: float = 10.0` — lerp factor
- behaviour:
    - on ready: computes a fixed offset and sets `rotation = (-pitch, yaw, 0)`
    - per process: lerps `global_position` toward `target.global_position + offset`; rotation never changes
