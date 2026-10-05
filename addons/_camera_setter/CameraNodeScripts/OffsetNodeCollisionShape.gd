@tool
class_name OffsetNodeCollisionShape extends CollisionShape2D

#region Exports
@export_category("OffsetSpeed")
@export_range(0, 100, 1) var OffsetTransitionSpeed: float = 50.0

@export_category("OffsetSliders")
@export_range(-100, 100, 1) var OffsetX := 0.0:
	set(Value):
		OffsetX = Value
		Offset.x = Value
@export_range(-100, 100, 1) var OffsetY := 0.0:
	set(Value):
		OffsetY = Value
		Offset.y = Value

var Offset: Vector2 = Vector2.ZERO:
	set(Value):
		Offset = Value
		queue_redraw()
#endregion


func _enter_tree() -> void:
	if !Engine.is_editor_hint(): return 

	name = "OffsetNodeCollisionShape"
	
	var Rectangle := RectangleShape2D.new()
	Rectangle.size = Vector2(64, 64)
	shape = Rectangle
	
	if Engine.is_editor_hint():
		call_deferred("SelectShape")

func _ready() -> void:
	get_parent().CameraCenterEnteredOffsetNode.connect(ApplyOffset)

func SelectShape() -> void:
	EditorInterface.edit_node(self)

func _draw() -> void:
	if not Engine.is_editor_hint():
		return
	
	var Text := str(Offset)
	var Font := ThemeDB.fallback_font
	var FontSize := 16
	var TextWidth := Font.get_string_size(Text, HORIZONTAL_ALIGNMENT_LEFT, -1, FontSize).x
	
	draw_string(
		ThemeDB.fallback_font,                  #font
		Vector2(Offset.x - (TextWidth / 2), OffsetY), #position
		Text,                                   #text
		HORIZONTAL_ALIGNMENT_LEFT,              #alignment
		-1,                                     #width
		16                                      #font size
	)

func ApplyOffset(CameraCenter: Area2D):
	var CameraTween = create_tween()
	CameraTween.set_ease(Tween.EASE_IN_OUT)
	CameraTween.set_trans(Tween.TRANS_SINE)
	
	var Duration = CameraCenter.position.distance_to(Offset) / OffsetTransitionSpeed
	
	CameraTween.tween_property(CameraCenter, "position", Offset, Duration)
