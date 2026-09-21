class_name InputComponent
extends Node2D


@export_category("Components Imports")
@export var VelocityComponent: VelocityComponent


var MovementDirection: Vector2


func _process(_delta: float) -> void:
	MovementDirection = Input.get_vector(
		"MoveLeft",
		"MoveRight",
		"MoveUp",
		"MoveDown"
	)
