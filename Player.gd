extends CharacterBody3D

@export var speed := 5.0
@export var jump_velocity := 4.0

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta: float) -> void:
    var direction := Vector3(
        Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
        0.0,
        Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
    )

    if direction.length() > 0:
        direction = direction.normalized()
        velocity.x = direction.x * speed
        velocity.z = direction.z * speed
    else:
        velocity.x = move_toward(velocity.x, 0.0, speed)
        velocity.z = move_toward(velocity.z, 0.0, speed)

    if not is_on_floor():
        velocity.y -= gravity * delta
    elif Input.is_action_just_pressed("jump"):
        velocity.y = jump_velocity

    move_and_slide()
