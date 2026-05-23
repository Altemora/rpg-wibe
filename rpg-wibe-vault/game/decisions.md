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
