---
tags: [roadmap]
summary: sequenced plan of work items past the current prototype; architecture for each is out of scope, decided when the item is picked up
updated: 2026-05-24
---

- one bullet per work item; format: `name — what it produces, why it is next`
- order by intended sequence; reorder freely as priorities shift
- architecture of each item is decided when the item is started, not here
- items:
    - replace throwaway prototype — first dedicated agent task; produces the real extensible character pipeline (state machine, intent layer, animation controller, movement) that supersedes `scripts/player.gd`, `scripts/iso_camera.gd`, `scenes/test_world.tscn`; blocks every other item below
    - idle animation per direction — adds a multi-frame breathing/sway idle to complement the single-frame idle currently used
    - attack state pipeline — implements the `preparation, charging, attacking, returning` sub-phases from [[game/mechanics/character-rendering]]; unlocks combat
    - hurt, death, cast, work states — added per mechanic need; minimum: hurt and death after combat lands
    - anchor json extraction pipeline — post-process pixellab output to detect `head, right_hand, left_hand, back, belt` pixel positions per frame and emit a sidecar json; required by overlay equipment
    - palette-indexed body shader — replaces body key colors via a `palette.png` column lookup; unlocks free reskins and body-conformant equipment
    - overlay-attached equipment renderer — shape-changing items rendered as 1-frame × 8-dir overlays snapping to anchors; covers helmet, weapon, cape, shield, bag
    - tile world generation — replace the single flat plane with chunk streaming as described in [[tech/architecture]]
    - terrain heights — flat, ramp, cliff transitions per [[game/mechanics]]
    - input intent layer — single intent shape produced by player keyboard, ai, or network source; prerequisite for npc and multiplayer
    - character state machine — extensible across the states above
- external references (used while own code is sparse; drop the bullet when the reference stops being useful):
    - `D:/Space/Source/Godot/LearnToGame` — sibling godot 4 project on this machine; read for godot idioms (composition via child nodes, signals, resources, `CharacterBody3D` flow) while rpg-wibe has little of its own to study; not a source of architecture decisions
