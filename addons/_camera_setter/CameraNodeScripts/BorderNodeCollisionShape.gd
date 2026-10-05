@tool
class_name BorderNodeCollisionShape extends CollisionShape2D

#region Variables
@export var OneWay: bool = false:
	set(value):
		OneWay = value
		one_way_collision = value
		notify_property_list_changed()

@export_group("One Way Direction", "OneWay_")
@export var OneWay_Left := false
@export var OneWay_Right := false
@export var OneWay_Up := false
@export var OneWay_Down := true

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

#func _ready() -> void:
	#get_parent().CameraCenterEnteredBorderNode.connect()
#
#func ApplyBorderRestrictions(Area: Area2D) -> void:
	#pass

func SelectShape() -> void:
	EditorInterface.edit_node(self)
