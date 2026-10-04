class_name VelocityComponent
extends Node2D

@export_category("Movement Specifics")
@export var Speed: float

@export_category("Object Imports")
@export var SelectedMoveableObject: CharacterBody2D

@export_category("Component Imports")
@export var InputComponent: InputComponent
#@export var NavigationComponent: NavigationComponent

func _process(_delta: float) -> void:
	MovementCaller()
	
	SelectedMoveableObject.move_and_slide()

func MovementCaller() -> void:
	if InputComponent:
		Movement(Speed, InputComponent.MovementDirection)

func Movement(ObjectSpeed: float, Direction: Vector2) -> void:
	SelectedMoveableObject.velocity = ObjectSpeed * Direction 
