extends Node3D

@export var size_x := 16
@export var size_z := 16

var cube_mesh := BoxMesh.new()
var material := StandardMaterial3D.new()
var multimesh := MultiMesh.new()
var multimesh_instance := MultiMeshInstance3D.new()
var blocks := {}

func _spawn_block(pos: Vector3i, index: int = -1) -> Dictionary:
    if index == -1:
        index = multimesh.instance_count
        multimesh.instance_count += 1

    multimesh.set_instance_transform(index, Transform3D(Basis(), pos))
    multimesh.set_instance_visible(index, true)
    multimesh.set_instance_color(index, Color.WHITE)

    var body = StaticBody3D.new()
    var shape = CollisionShape3D.new()
    var box = BoxShape3D.new()
    box.size = Vector3.ONE
    shape.shape = box
    body.add_child(shape)
    body.position = pos
    add_child(body)

    return {"index": index, "body": body}

func _ready():
    material.albedo_color = Color(0.6, 0.8, 0.6)

    multimesh.transform_format = MultiMesh.TRANSFORM_3D
    multimesh.color_format = MultiMesh.COLOR_8BIT

    multimesh_instance.multimesh = multimesh
    multimesh_instance.mesh = cube_mesh
    multimesh_instance.material_override = material
    add_child(multimesh_instance)

    var i = 0
    multimesh.instance_count = size_x * size_z
    for x in range(size_x):
        for z in range(size_z):
            var pos := Vector3i(x, 0, z)
            multimesh.set_instance_transform(i, Transform3D(Basis(), pos))
            multimesh.set_instance_visible(i, true)
            multimesh.set_instance_color(i, Color.WHITE)

            var body = StaticBody3D.new()
            var shape = CollisionShape3D.new()
            var box = BoxShape3D.new()
            box.size = Vector3.ONE
            shape.shape = box
            body.add_child(shape)
            body.position = pos
            add_child(body)

            blocks[pos] = {"index": i, "body": body}
            i += 1
