class_name CameraCenterComponent extends CharacterBody2D

@export var VelocityComponent: VelocityComponent

var InOffsetNode: bool = false

func _physics_process(delta: float) -> void:
	move_and_slide()
	
	if is_on_floor() or is_on_wall() or is_on_ceiling() or InOffsetNode: return
	

	position = position.move_toward(Vector2.ZERO, VelocityComponent.Speed * delta)
