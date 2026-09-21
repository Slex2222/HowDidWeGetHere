class_name InputComponent
extends Node2D

signal FastQuitPressed

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

func Quit() -> void:
	FastQuit = Input.is_action_just_pressed("FastQuit")
	if !FastQuit: return # return if fastquit is not pressed
	
	FastQuitPressed.emit()
