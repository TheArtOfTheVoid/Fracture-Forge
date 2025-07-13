extends Node3D

@export var size_x := 16
@export var size_z := 16

var cube_mesh := CubeMesh.new()
var material := StandardMaterial3D.new()

func _ready():
    material.albedo_color = Color(0.6, 0.8, 0.6)
    for x in range(size_x):
        for z in range(size_z):
            var block = MeshInstance3D.new()
            block.mesh = cube_mesh
            block.material_override = material
            block.position = Vector3(x, 0, z)
            add_child(block)
