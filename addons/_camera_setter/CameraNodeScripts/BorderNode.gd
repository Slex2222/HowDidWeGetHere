@tool
class_name BorderNode extends Area2D

var BorderNodeShape: BorderNodeCollisionShape

signal CameraCenterEnteredOffsetNode(CameraCenter: Area2D)

func _enter_tree() -> void:
	if get_child_count() == 0:
		BorderNodeShape = BorderNodeCollisionShape.new()

		add_child(BorderNodeShape)

		if Engine.is_editor_hint():
			BorderNodeShape.owner = get_tree().edited_scene_root

func _ready() -> void:
	if Engine.is_editor_hint():
		return

	area_entered.connect(CameraCenteredEntered)

func CameraCenteredEntered(Area: Area2D) -> void:
	CameraCenterEnteredOffsetNode.emit(Area)
