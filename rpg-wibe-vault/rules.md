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
- methods listed as sub-bullets under their class detail file when non-trivial
- frontmatter required on every md file: `tags`, `summary`, `updated`
- tags: lowercase plain words, only `_` allowed as special char
- summary: one short sentence, under 120 chars
- updated: `yyyy-mm-dd` of last meaningful edit
- read order: index file, then section file, then leaf file
- never load whole vault
- search: prefer `search_simple` or `search_query` with narrow terms; avoid `vault_list` of root then bulk read
- write rules: `vault_patch` for targeted edits, `vault_append` for logs, `vault_write` for new files
- one fact one file; link via `[[wikilink]]`
- file content style: bullets only, no headings except top frontmatter, no decorative formatting; markdown tables are allowed for table-of-rows index files (currently `code/files.md`)
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
    - `roadmap.md` — sequenced plan of work items past the current state; architecture decided per item when picked up
    - `game/concept.md` — pitch, pillars, world, character, resources, coop, aesthetic
    - `game/decisions.md` — design decisions log
    - `game/mechanics.md` — flat map of mechanics
    - `game/mechanics/<name>.md` — detail file for a complex mechanic
    - `code/files.md` — table of all source files (path | role); rows, not bullets
    - `code/classes.md` — flat index of classes; one bullet per class as a wikilink to the detail file
    - `code/classes/<name>.md` — per-class detail (extends, declared-in path, methods, status, related mechanics)
    - `code/scenes.md` — flat index of scenes; one bullet per scene as a wikilink to the detail file
    - `code/scenes/<name>.md` — per-scene detail (root node, attached script, children, status)
    - `tech/stack.md` — engine, renderer, world constants, art tooling
    - `tech/conventions.md` — naming, patterns, layout
    - `tech/architecture.md` — code architecture patterns and cross-cutting technical decisions
    - `issues/` — post-mortems for resolved bugs; file naming and aggregation format are tbd, defined when the first bug is recorded
- update triggers:
    - new source file -> add a row to `code/files.md`
    - new class declared with `class_name` -> create `code/classes/<name>.md` (use the per-class template) and add a wikilink bullet to `code/classes.md`
    - new method on existing class -> add a sub-bullet under `methods:` in that class's detail file if non-trivial
    - new scene -> add a row to `code/files.md`, create `code/scenes/<name>.md` (use the per-scene template) and add a wikilink bullet to `code/scenes.md`
    - file or class or scene renamed -> patch the row/bullet and rename the detail file
    - file or class or scene removed -> remove the row/bullet and delete the detail file
    - new mechanic -> add bullet to `game/mechanics.md`; create detail file only if complex
    - mechanic changed -> patch the bullet, or patch the detail file if one exists
    - tech decision -> append to `tech/stack.md`, `tech/conventions.md`, or `tech/architecture.md` depending on scope
    - architectural pattern change -> patch `tech/architecture.md`
    - new open question -> add to the `open architecture questions` section of `tech/architecture.md`
    - design decision -> append row to `game/decisions.md`
    - new planned work item -> append row to `roadmap.md`
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

- entity-table file template (used by `game/mechanics.md`):

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

- table-of-rows file template (used by `code/files.md`):

```
---
tags: [<section>, <kind>]
summary: <one sentence>
updated: <yyyy-mm-dd>
---

- short usage note(s) as bullets above the table

| <col1> | <col2> |
|---|---|
| <value> | <value> |
```

- per-class detail file template (used by `code/classes/<name>.md`):

```
---
tags: [code, class]
summary: <one sentence>
updated: <yyyy-mm-dd>
---

- name: `ClassName`
- declared in: `res://path/to/file.gd`
- extends: `BaseClass`
- status: production | prototype | deprecated
- responsibility: <one-line role; expand to sub-bullets if needed>
- exported parameters:
    - `name: type = default` — what it is
- methods:
    - `method_name(args) -> return_type` — what it does
- related: [[game/mechanics/<name>]] (when applicable)
```

- per-scene detail file template (used by `code/scenes/<name>.md`):

```
---
tags: [code, scene]
summary: <one sentence>
updated: <yyyy-mm-dd>
---

- name: `scene_name`
- declared in: `res://path/to/file.tscn`
- root node: `<NodeType>`
- attached script: `ClassName` | none
- status: production | prototype | deprecated
- children:
    - `ChildName` (`NodeType`) — role; nested children as sub-bullets when relevant
```
