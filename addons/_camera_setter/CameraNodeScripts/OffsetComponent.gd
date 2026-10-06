@tool
class_name OffsetNode extends Area2D

var OffsetNodeShape: OffsetNodeCollisionShape

func _enter_tree() -> void:
	if get_child_count() == 0:
		OffsetNodeShape = OffsetNodeCollisionShape.new()

		add_child(OffsetNodeShape)

		if Engine.is_editor_hint():
			OffsetNodeShape.owner = get_tree().edited_scene_root
