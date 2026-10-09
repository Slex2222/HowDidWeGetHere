@tool
class_name BorderNodeCollisionShape extends CollisionShape2D

#region Variables
@export_range(0.0, 100.0, 1.0) var BorderRevertSpeed: float = 10.0
#endregion

func _enter_tree() -> void:
	if !Engine.is_editor_hint(): return 
	name = "BorderNodeCollisionShape"
	
	var Rectangle := RectangleShape2D.new()
	Rectangle.size = Vector2(64, 64)
	shape = Rectangle
	
	if Engine.is_editor_hint():
		call_deferred("SelectShape")

func SelectShape() -> void:
	EditorInterface.edit_node(self)
