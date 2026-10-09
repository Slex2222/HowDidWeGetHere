@tool
class_name BorderNodeCollisionShape extends CollisionShape2D

@export_range(0.0, 100.0, 1.0)
var BorderRevertSpeed: float = 10.0

func _ready() -> void:
	if !Engine.is_editor_hint():
		return

	name = "BorderNodeCollisionShape"

	var rectangle := RectangleShape2D.new()
	rectangle.size = Vector2(64, 64)
	shape = rectangle
	
	call_deferred("SelectShape") 

func SelectShape() -> void:
	if !Engine.is_editor_hint(): return
	
	EditorInterface.edit_node(self)
