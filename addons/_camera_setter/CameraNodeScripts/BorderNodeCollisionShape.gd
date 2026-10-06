@tool
class_name BorderNodeCollisionShape extends CollisionShape2D

#region Variables
@export var OneWay: bool = false:
	set(value):
		OneWay = value
		notify_property_list_changed()

@export_group("One Way Direction", "OneWay_")
enum Directions {
	Left,
	Right,
	Up,
	Down
}

@export var OneWay_Directions: Directions = Directions.Left:
	set(value):
		OneWay_Directions = value
		
		if value == Directions.Left:
			OneWayDirectionVector = Vector2(-1, 0)
		if value == Directions.Right:
			OneWayDirectionVector = Vector2(1, 0)
		if value == Directions.Up:
			OneWayDirectionVector = Vector2(0, -1)
		if value == Directions.Down:
			OneWayDirectionVector = Vector2(0, 1)

var OneWayDirectionVector: Vector2 = Vector2(-1, 0)
#endregion

func _validate_property(property: Dictionary) -> void:
	if property.name.begins_with("OneWay_") and !OneWay:
		property.usage = PROPERTY_USAGE_NO_EDITOR

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
