extends Node3D

@export var reach := 5.0
var blocks := {}
var world
<<<<<<< ptbk3o-codex/set-up-godot-project-structure
var multimesh : MultiMesh
var highlighted_index := -1
var last_highlighted_index := -1
=======
var cube_mesh : Mesh
var cube_material : Material
var highlighted : Vector3i
>>>>>>> main
@onready var ray := $RayCast3D

func _ready():
    world = get_tree().current_scene.get_node("World")
    ray.target_position = Vector3(0, 0, -reach)
    ray.enabled = true
    var terrain = world.get_node("VoxelTerrain")
<<<<<<< ptbk3o-codex/set-up-godot-project-structure
    blocks = terrain.blocks
    multimesh = terrain.multimesh

func _physics_process(delta):
    ray.force_raycast_update()
    var idx := -1
    if ray.is_colliding():
        var p = ray.get_collision_point()
        var pos = Vector3i(int(round(p.x)), int(round(p.y)), int(round(p.z)))
        if blocks.has(pos):
            idx = blocks[pos]["index"]
    highlighted_index = idx

func _process(delta):
    if highlighted_index != last_highlighted_index:
        if last_highlighted_index >= 0:
            multimesh.set_instance_color(last_highlighted_index, Color.WHITE)
        if highlighted_index >= 0:
            multimesh.set_instance_color(highlighted_index, Color.RED)
        last_highlighted_index = highlighted_index
=======
    for child in terrain.get_children():
        if child is MeshInstance3D:
            blocks[Vector3i(int(child.position.x), int(child.position.y), int(child.position.z))] = child
    if terrain.get_child_count() > 0:
        var sample := terrain.get_child(0) as MeshInstance3D
        cube_mesh = sample.mesh
        cube_material = sample.material_override
    highlighted = Vector3i(999999,999999,999999)

func _physics_process(delta):
    ray.force_raycast_update()
    var hit_block : Vector3i = Vector3i(999999,999999,999999)
    if ray.is_colliding():
        var p = ray.get_collision_point()
        hit_block = Vector3i(int(round(p.x)), int(round(p.y)), int(round(p.z)))
    if hit_block != highlighted:
        if blocks.has(highlighted):
            blocks[highlighted].modulate = Color.WHITE
        highlighted = hit_block
        if blocks.has(highlighted):
            blocks[highlighted].modulate = Color.RED
>>>>>>> main

func _unhandled_input(event):
    if not ray.is_colliding():
        return
    var p = ray.get_collision_point()
    var n = ray.get_collision_normal()
    var block_pos = Vector3i(int(round(p.x)), int(round(p.y)), int(round(p.z)))
    if event.is_action_pressed("mine"):
        if blocks.has(block_pos):
<<<<<<< ptbk3o-codex/set-up-godot-project-structure
            var data = blocks[block_pos]
            multimesh.set_instance_visible(data["index"], false)
            data["body"].queue_free()
=======
            blocks[block_pos].queue_free()
>>>>>>> main
            blocks.erase(block_pos)
    elif event.is_action_pressed("build"):
        var place_pos = block_pos + Vector3i(int(n.x), int(n.y), int(n.z))
        if not blocks.has(place_pos):
<<<<<<< ptbk3o-codex/set-up-godot-project-structure
            var terrain = world.get_node("VoxelTerrain")
            var index := -1
            for i in range(multimesh.instance_count):
                if not multimesh.is_instance_visible(i):
                    index = i
                    break
            if index == -1:
                index = multimesh.instance_count
                multimesh.instance_count += 1
            blocks[place_pos] = terrain._spawn_block(place_pos, index)
=======
            var block = MeshInstance3D.new()
            block.mesh = cube_mesh
            block.material_override = cube_material
            block.position = Vector3(place_pos)
            world.get_node("VoxelTerrain").add_child(block)
            blocks[place_pos] = block
>>>>>>> main
