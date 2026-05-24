---
tags: [code, class]
summary: index of classes; detail per class lives in `code/classes/<name>.md`
updated: 2026-05-24
---

- one bullet per class declared with `class_name`; format: `[[code/classes/<name>|ClassName]] — one-line role`
- detail file holds extends, declared-in path, methods, related mechanics, status (prototype / production), notes
- add/remove the bullet in the same change that adds/removes the class file
- order by name

- entries:
    - [[code/classes/iso_camera|IsoCamera]] — throwaway prototype orthographic camera; fixed iso angle, lerp-follows a node
    - [[code/classes/player|Player]] — throwaway prototype `CharacterBody3D` controller for the walk test
