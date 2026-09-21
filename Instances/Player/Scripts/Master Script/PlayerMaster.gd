extends CharacterBody2D


@export_category("Component Imports")
@export var InputComponent: InputComponent 
@export var VelocityComponent: VelocityComponent 

func _physics_process(_delta: float) -> void:
	ApplyMovement()

func ApplyMovement():
	VelocityComponent.Movement(VelocityComponent.Speed, InputComponent.MovementDirection)
