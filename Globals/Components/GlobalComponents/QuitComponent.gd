class_name QuitComponent extends Node2D

@export_category("Component Imports")
@export var InputComponent: InputComponent

func _ready() -> void:
	InputComponent.FastQuitPressed.connect(QuitGame)

func QuitGame() -> void:
	get_tree().quit()
