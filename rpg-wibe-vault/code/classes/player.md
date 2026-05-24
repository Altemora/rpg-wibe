---
tags: [code, class, prototype]
summary: throwaway prototype CharacterBody3D controller used to validate the pixellab → spriteframes walk pipeline
updated: 2026-05-24
---

- name: `Player`
- declared in: `res://scripts/player.gd`
- extends: `CharacterBody3D`
- status: throwaway prototype; replaceable per [[game/decisions]] and [[roadmap]]
- responsibility:
    - read screen-relative WASD/arrow input
    - rotate input by camera yaw to align with iso world axes
    - drive `move_and_slide` on the XZ plane
    - choose one of 8 sprite animations from screen-space input direction
    - build a `SpriteFrames` resource at runtime from on-disk pixellab output
- exported parameters:
    - `idle_speed: float = 4.0` — animation fps for idle clips
    - `walk_speed: float = 10.0` — animation fps for walk clips
- methods:
    - `_dir_from_input(v: Vector2) -> String` — bins screen-space input into one of 8 compass directions
    - `_build_sprite_frames() -> SpriteFrames` — loads `assets/characters/test-female-placeholder/{idle,walk}/<dir>/frame_<n>.png` and assembles a `SpriteFrames` resource
- related: [[game/mechanics/character-rendering]]
