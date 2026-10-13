class_name Player extends CharacterBody2D

signal CameraCenterReturnedToPlayer

@export var CameraCenter: CameraCenterComponent:
	set(value):
		CameraCenter = value
		update_configuration_warnings()

func _physics_process(_delta: float) -> void:
	if !CameraCenter.global_position.distance_to(global_position) < 1: return
	
	CameraCenterReturnedToPlayer.emit()

func _get_configuration_warnings() -> PackedStringArray:
	var Warnings: PackedStringArray
	
	if !CameraCenter:
		Warnings.append("Need a Cameracenter Component to function")
	
	return Warnings
