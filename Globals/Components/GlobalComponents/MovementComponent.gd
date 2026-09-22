class_name VelocityComponent
extends Node2D

@export_category("Movement Specifics")
@export var Speed: float

@export_category("Object Imports")
@export var SelectedMoveableObject: CharacterBody2D

@export_category("Component Imports")
@export var InputComponent: InputComponent

func _process(_delta: float) -> void:
	Movement(Speed, InputComponent.MovementDirection)
	
	SelectedMoveableObject.move_and_slide()

func Movement(ObjectSpeed: float, Direction: Vector2) -> void:
	SelectedMoveableObject.velocity = ObjectSpeed * Direction 
