@tool
class_name OffsetNode extends Area2D

var OffsetNodeShape: OffsetNodeCollisionShape

signal CameraCenterEnteredOffsetNode

func _enter_tree() -> void:
	if get_child_count() == 0:
		OffsetNodeShape = OffsetNodeCollisionShape.new()

		add_child(OffsetNodeShape)

		if Engine.is_editor_hint():
			OffsetNodeShape.owner = get_tree().edited_scene_root

func _ready() -> void:
	if Engine.is_editor_hint():
		return

	body_entered.connect(CameraCenteredEntered)
	body_exited.connect(CameraCenterExited)

func CameraCenteredEntered(Body: CameraCenterComponent) -> void:
	CameraCenterEnteredOffsetNode.emit(Body)
	
	Body.InOffsetNode = true


func CameraCenterExited(Body: CameraCenterComponent) -> void:
	Body.InOffsetNode = false
