extends Node3D

@export var reach := 5.0
var blocks := {}
var world
var multimesh : MultiMesh
var highlighted_index := -1
var last_highlighted_index := -1
@onready var ray := $RayCast3D

func _ready():
    world = get_tree().current_scene.get_node("World")
    ray.target_position = Vector3(0, 0, -reach)
    ray.enabled = true
    var terrain = world.get_node("VoxelTerrain")
    await terrain.ready
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
    if multimesh == null:
        return
    if highlighted_index != last_highlighted_index:
        if last_highlighted_index >= 0:
            multimesh.set_instance_color(last_highlighted_index, Color.WHITE)
        if highlighted_index >= 0:
            multimesh.set_instance_color(highlighted_index, Color.RED)
        last_highlighted_index = highlighted_index

func _unhandled_input(event):
    if multimesh == null:
        return
    if not ray.is_colliding():
        return
    var p = ray.get_collision_point()
    var n = ray.get_collision_normal()
    var block_pos = Vector3i(int(round(p.x)), int(round(p.y)), int(round(p.z)))
    if event.is_action_pressed("mine"):
        if blocks.has(block_pos):
            var data = blocks[block_pos]
            multimesh.set_instance_visible(data["index"], false)
            data["body"].queue_free()
            blocks.erase(block_pos)
    elif event.is_action_pressed("build"):
        var place_pos = block_pos + Vector3i(int(n.x), int(n.y), int(n.z))
        if not blocks.has(place_pos):
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
