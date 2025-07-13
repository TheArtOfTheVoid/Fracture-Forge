extends Area3D

func _on_body_entered(body: Node) -> void:
    if body.name == "Player":
        print("You win!")
