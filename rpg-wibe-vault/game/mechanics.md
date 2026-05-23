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
