# Cradle-to-Crucible (prototype)
A tiny Godot 4 project demonstrating a simple voxel-style movement test.

## How to run
1. Open the project with Godot 4.x.
2. Press **F5** to play.

### Controls
- **WASD**: Move the player cube
- **Space**: Jump
- **Esc**: Quit
- **Left-click**: Mine block
- **Right-click**: Build block
- Cross-hair indicates current target block
- Engine now batches ground cubes via MultiMesh

## Local export
Run the helper script if the Godot CLI is installed:

```bash
./tools/export.sh
```

CI automatically builds Windows and Web versions on every push.

