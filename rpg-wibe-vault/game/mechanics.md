---
tags: [game, mechanic]
summary: flat map of all game mechanics (name — role)
updated: 2026-05-24
---

- one bullet per mechanic; format: `name — what it is, what it does`
- simple mechanics live inline as a single bullet
- complex mechanics get a detail file `game/mechanics/<name>.md`; reference it as `[[game/mechanics/<name>|<name>]] — short role`
- entries:
    - combat — primary action loop; starting weapons are sword and magic; death does not end the game (respawn at start, inventory preserved)
    - building — block-based grid placement; filled cell is a wall; a house becomes inhabitable once its structure is valid (closed perimeter + roof); player builds blocks first, later places blueprints and npcs build them over time
    - npc-settlement — find an npc in the world, bring it to the settlement, house it in a ready building; future: complex npc ai with needs, interactions, autonomous building
    - inventory — six equipment slots plus carry capacity from the bag slot; consumables capped by the belt slot; details under character build in `concept.md`
    - world-chunking — world has no hard size limit; stored as chunks streamed in/out with two-radius hysteresis (`R_load` < `R_unload`) to prevent thrash on chunk borders
    - terrain-heights — ground cells carry integer height; transition between neighbours (flat / ramp / cliff) is derived from Δh plus biome's `slope_allowed` rule, not stored
    - wall-topology — wall corners, T-junctions and ends are derived from a 4-bit neighbor mask, not stored; doors and windows are blocks with `Passable` and `Sightline` components, so flood-fill still treats them as walls for interior detection
    - interior-mode — when player enters a building, surrounding world dims to near-black via shader uniform and front-facing walls are `discard`-cut at a low cutoff height (sharp slice, not transparency); back walls and interior stay fully visible
    - [[game/mechanics/character-rendering|character-rendering]] — single body sprite per frame, palette-indexed shader for body-conformant equipment, anchor-attached overlay sprites for shape-changing equipment
