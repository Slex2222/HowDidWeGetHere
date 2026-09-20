class_name VelocityComponent
extends Node2D

@export_category("Movement Specifics")
@export var Speed: float

@export_category("Object Imports")
@export var SelectedMoveableObject: CharacterBody2D

func Movement(ObjectSpeed: float, Direction: Vector2) -> void:
	SelectedMoveableObject.velocity = ObjectSpeed * Direction 

func _process(_delta: float) -> void:
	SelectedMoveableObject.move_and_slide()
