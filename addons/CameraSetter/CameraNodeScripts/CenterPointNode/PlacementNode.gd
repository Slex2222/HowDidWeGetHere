@tool
class_name PlacementNode extends Node2D

func _ready() -> void:
	if !Engine.is_editor_hint():
		return

	name = "PlacementNode"
	
	EditorInterface.edit_node(self)
