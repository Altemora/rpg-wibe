---
tags:
  - game
  - decision
summary: log of cross-cutting game design decisions
updated: 2026-05-24
---

- append one bullet per decision: `yyyy-mm-dd | choice | rationale | status`
- status: `active` or `superseded by [[file]]`
- entries:
    - 2026-05-24 | death respawns the player at the start with inventory preserved | non-punishing loop; reinforces meditative pillar | active
    - 2026-05-24 | no archery as a starting weapon line | melee and magic provide enough combat depth for early scope | active
    - 2026-05-24 | playstyle defined by equipment, no explicit classes | maps to the "no classes" pillar; equipment slots are the only build axis | active
    - 2026-05-24 | aesthetic locked to pixel art on 2d billboards in a 3d world | gives isometric look with cheaper asset production than full 3d models | active
    - 2026-05-24 | coop is planned 2-4 players; multiplayer architecture must be locked before layer 2 | networking model influences save format, world authority, and npc sync | active
    - 2026-05-24 | world has no hard size limit; chunked storage streamed on demand with two-radius hysteresis | infinite-feeling world without thrash; 1024 stays as a rule-of-thumb location size | active
    - 2026-05-24 | walls, buildings, interiors and terrain transitions are derived from grid data, not stored as entities | player/npc/editor all write only blocks and heights; one engine interprets them, no duplication, no desync | active
    - 2026-05-24 | doors and windows are blocks with `Passable` and `Sightline` components, not wall modifications | composable; flood-fill interior detection keeps working uniformly | active
    - 2026-05-24 | interior mode uses fragment `discard` on front walls and a world-darken shader, not material transparency | gives the classic sharp-slice cutaway look; clean separation between "in" and "out" without ghosting | active
    - 2026-05-24 | occlusion detection uses cell-walk along camera→player line, not physics raycast | grid is the source of truth; O(line length) cost, independent of building count; supersedes the raycast plan in [[tech/architecture]] | active
    - 2026-05-24 | art format locked: tile texture 32×32 px flat orthogonal artwork, character sprite 64×64 px 2d billboard | textures are not pre-distorted for isometry — flat art applied to 3d meshes, the camera angle gives the iso look; character resolution matches ~2-cell height at 32px/cell | active
    - 2026-05-24 | character rendered as a single body sprite per frame, not per-part composition | pixellab generates a whole character per prompt; per-part split was rejected as unnecessary once equipment is decoupled from body geometry | active
    - 2026-05-24 | 8 iso directions (`n, ne, e, se, s, sw, w, nw`) from the start | smoother movement than 4; pixellab `rotate artwork` derives 7 directions from 1, keeping art cost manageable | active
    - 2026-05-24 | body coloration via palette-indexed shader: body painted with project-defined key colors per zone, runtime `palette.png` maps key index to actual color | swap-only customization for skin/race/clothing/light armor without new sprites; one body anim covers all visual variants | active
    - 2026-05-24 | equipment split by silhouette impact: body-conformant via palette swap, shape-changing via anchor-attached overlay sprite (1 frame × 8 directions, no own animation) | body anim stays independent of equipment count; overlay items follow body via anchor metadata | active
    - 2026-05-24 | per-frame anchor points (`head, right_hand, back, ...`) stored as sidecar json next to spriteframes | overlays snap to anchors each frame so they follow body motion without per-equipment animation | active
    - 2026-05-24 | animation state list is open-ended; baseline `idle`, `walk`, `attack`; `death`, `hurt`, `cast`, `work` added per mechanic need | states are driven by gameplay, not pre-locked; pipeline auto-detects them from folder structure | active
    - 2026-05-24 | character size of 64 refers to the body height, not the sprite canvas; pixellab generates a canvas ~40% larger than body (size 64 → canvas ~90); canvas can grow further for effects without changing the body lock | clarifies an ambiguity in the earlier `64×64 px` lock that conflated body and canvas | active
    - 2026-05-24 | current `scripts/player.gd`, `scripts/iso_camera.gd` and `scenes/test_world.tscn` are a stylistically incorrect throwaway prototype used only to validate the asset pipeline (pixellab generation → 92×92 png → spriteframes → walking 8-dir on a flat plane); the full character pipeline is to be designed and written from scratch by a separate fresh agent task, not by extending these files | the prototype proved the round-trip works; the real character system deserves a clean start without inheriting prototype shape | active
