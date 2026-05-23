---
tags: [rules]
summary: vault usage rules for ai agents
updated: 2026-05-24
---

- vault is single source of truth; read before code change, update after code change
- access only via obsidian mcp; never edit files directly if mcp is down — fix mcp first
- no source code is stored in the vault; vault holds only descriptions and decisions about code
- entity description format: `name — what it is, what it does` (one line per entity)
- applies to: code files, classes, methods, scenes, mechanics, resources, issues — anything with a name
- methods listed as sub-bullets under their class line when non-trivial
- frontmatter required on every md file: `tags`, `summary`, `updated`
- tags: lowercase plain words, only `_` allowed as special char
- summary: one short sentence, under 120 chars
- updated: `yyyy-mm-dd` of last meaningful edit
- read order: index file, then section file, then leaf file
- never load whole vault
- search: prefer `search_simple` or `search_query` with narrow terms; avoid `vault_list` of root then bulk read
- write rules: `vault_patch` for targeted edits, `vault_append` for logs, `vault_write` for new files
- one fact one file; link via `[[wikilink]]`
- file content style: bullets only, no headings except top frontmatter, no decorative formatting
- linking convention:
    - reference to another vault file as a navigation target -> `[[wikilink]]`
    - reference to a path in the codebase outside the vault -> backticks `` `res://...` ``
    - reference to a vault path used as a schema identifier in rules or templates -> backticks
    - reference to a directory inside the vault -> always link to its flat index file (wikilink), never backtick the dir
    - never mix wikilinks and backticks for items of the same kind in one list
- for each collection of entities there is a flat index file at the parent level; detail files (when needed) live in a sibling subfolder
- structure:
    - `index.md` — entry point
    - `rules.md` — this file
    - `list.base` — full vault file table (obsidian base)
    - `game/concept.md` — pitch, pillars, world, character, resources, coop, aesthetic
    - `game/decisions.md` — design decisions log
    - `game/mechanics.md` — flat map of mechanics
    - `game/mechanics/<name>.md` — detail file for a complex mechanic
    - `code/files.md` — flat map of all code files (path — role)
    - `code/classes.md` — flat map of classes (name — role, methods as sub-bullets)
    - `code/scenes.md` — flat map of scenes (name — role)
    - `tech/stack.md` — engine, renderer, world constants, art tooling
    - `tech/conventions.md` — naming, patterns, layout
    - `tech/architecture.md` — code architecture patterns and cross-cutting technical decisions
    - `issues/` — post-mortems for resolved bugs; file naming and aggregation format are tbd, defined when the first bug is recorded
- update triggers:
    - new script -> add bullet to `code/files.md` and, if class declared, to `code/classes.md`
    - new method on existing class -> add sub-bullet under that class in `code/classes.md` if non-trivial
    - new scene -> add bullet to `code/files.md` and `code/scenes.md`
    - file or class renamed -> patch the bullet in place
    - file or class removed -> delete the bullet
    - new mechanic -> add bullet to `game/mechanics.md`; create detail file only if complex
    - mechanic changed -> patch the bullet, or patch the detail file if one exists
    - tech decision -> append to `tech/stack.md`, `tech/conventions.md`, or `tech/architecture.md` depending on scope
    - architectural pattern change -> patch `tech/architecture.md`
    - new open question -> add to the `open architecture questions` section of `tech/architecture.md`
    - design decision -> append row to `game/decisions.md`
    - resolved bug -> tbd until the issues format is defined
- file template (copy frontmatter, fill body as bullets):

```
---
tags: [<section>, <subtopic>]
summary: <one sentence>
updated: <yyyy-mm-dd>
---

- <bullet>
- <bullet>
```

- entity-table file template (used by `code/files.md`, `code/classes.md`, `code/scenes.md`, `game/mechanics.md`):

```
---
tags: [<section>, <kind>]
summary: <one sentence>
updated: <yyyy-mm-dd>
---

- <name> — <one-line role>
- <name> — <one-line role>
    - <method_or_subitem> — <one-line role>
```
