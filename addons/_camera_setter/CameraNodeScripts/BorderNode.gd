@tool
class_name BorderNode extends StaticBody2D

var BorderNodeShape: BorderNodeCollisionShape

func _enter_tree() -> void:
	if get_child_count() == 0:
		BorderNodeShape = BorderNodeCollisionShape.new()

		add_child(BorderNodeShape)

		if Engine.is_editor_hint():
			BorderNodeShape.owner = get_tree().edited_scene_root

func _ready() -> void:
	if Engine.is_editor_hint():
		return
