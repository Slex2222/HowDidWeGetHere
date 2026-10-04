@tool
class_name OffsetNode extends Area2D

var OffsetNodeShape: OffsetNodeCollisionShape

signal CameraCenterEnteredOffsetNode(CameraCenter: Area2D)

func _enter_tree() -> void:
	if get_child_count() == 0:
		OffsetNodeShape = OffsetNodeCollisionShape.new()

		add_child(OffsetNodeShape)

		if Engine.is_editor_hint():
			OffsetNodeShape.owner = get_tree().edited_scene_root


func _ready() -> void:
	if Engine.is_editor_hint():
		return

	area_entered.connect(CameraCenteredEntered)


func CameraCenteredEntered(Area: Area2D) -> void:
	CameraCenterEnteredOffsetNode.emit(Area)
