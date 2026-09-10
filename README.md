# NinjaAdventure Godot starter

A browser-ready Godot project configured for Pompeii previews and publishing.

Pompeii discovers the starter metadata and deterministic container preview
from `.pompeii/metadata.json`, `.pompeii/preview.yml`, and the root
`Dockerfile`. The image exports the project for Web, then serves the immutable
build on port 4173.

Run `pompeii-godot doctor`, `pompeii-godot test`, `pompeii-godot asset-audit`,
and `pompeii-godot export-web` before publishing changes. Arrow keys and a
gamepad move the player.
