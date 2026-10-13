@tool
class_name CenterPointCollisionShape extends CameraCollisionShape

@export_range(0.0, 1000.0, 1.0) var TransitionSpeed = 300.0

var Offset: Vector2 = Vector2.ZERO

@onready var Placement: PlacementNode = $"../PlacementNode"

func _enter_tree() -> void:
	if !Engine.is_editor_hint():
		return

	name = "CenterPointCollisionShape"

	var rectangle := RectangleShape2D.new()
	rectangle.size = Vector2(64, 64)
	shape = rectangle

func _ready() -> void:
	ConnectOffset()

func ConnectOffset() -> void:
	Offset = Placement.global_position 
	
	get_parent().PlayerEnteredCenterPointNode.connect( 
		ApplyPosition.bind(Offset, TransitionSpeed)
		)
