class_name InputComponent
extends Node2D


@export_category("Components Imports")
@export var VelocityComponent: VelocityComponent
@export var QuitComponent: QuitComponent

var MovementDirection: Vector2
var FastQuit: bool

func _process(_delta: float) -> void:
	Velocity()
	Quit()

func Velocity() -> void:
	MovementDirection = Input.get_vector(
		"MoveLeft", 
		"MoveRight", 
		"MoveUp", 
		"MoveDown"
		)
	
	VelocityComponent.Movement(VelocityComponent.Speed, MovementDirection)

func Quit() -> void:
	FastQuit = Input.is_action_just_pressed("FastQuit")
	if !FastQuit: return # return if fastquit is not pressed
	
	QuitComponent.QuitGame()
