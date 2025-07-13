extends Area3D

@onready var ui := Label.new()

func _ready():
    connect("body_entered", _on_body_entered)

func _on_body_entered(body):
    if body.name == "Player":
        print("You win!")
        get_tree().quit()

