---
tags: [game, decision]
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
