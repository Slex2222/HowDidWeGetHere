extends CharacterBody2D


#@export_category("Component Imports")
#@export var InputComponent: InputComponent 
#@export var VelocityComponent: VelocityComponent 
#@export var QuitComponent: QuitComponent
#
#func _physics_process(_delta: float) -> void:
	#ApplyMovement()
	#
	#FastQuit()
#
#func ApplyMovement():
	#VelocityComponent.Movement(VelocityComponent.Speed, InputComponent.MovementDirection)
#
#func FastQuit():
	#if !InputComponent.FastQuit: return
	#
	#QuitComponent.QuitGame()
