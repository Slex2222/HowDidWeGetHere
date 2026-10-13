@tool
@icon("res://addons/CameraSetter/Icons/CustomCameraNode.svg")
class_name CenterPointNode extends Area2D

signal PlayerEnteredCenterPointNode(Body: Player)

var CenterPointShape: CenterPointCollisionShape
var Placement: PlacementNode

var InCenterPointNode := false 

@onready var Placementnode: PlacementNode = $PlacementNode

func _enter_tree() -> void:
	if not Engine.is_editor_hint(): return
	if get_child_count() == 2: return
	
	# check if it contains a CenterpointCollisionshape else add it
	if get_children().all(func(child): return not child is CenterPointCollisionShape): 
		CenterPointShape = CenterPointCollisionShape.new()

		add_child(CenterPointShape)

		if Engine.is_editor_hint():
			CenterPointShape.owner = get_tree().edited_scene_root
	
	if get_children().all(func(child): return not child is PlacementNode): 
		Placement = PlacementNode.new()

		add_child(Placement)

		if Engine.is_editor_hint():
			Placement.owner = get_tree().edited_scene_root

func _ready() -> void:
	body_entered.connect(PlayerEntered)
	body_exited.connect(PlayerExited)

func PlayerEntered(Body: Node2D) -> void:
	if !Body is Player: return
	var CameraCenter = Body.get_node("CameraCenter")
	
	CameraCenter.InCameraNode = true
	IgnoreParentPos(CameraCenter)
	
	PlayerEnteredCenterPointNode.emit(CameraCenter)

func PlayerExited(Body: Node2D) -> void:
	if !Body is Player: return
	var CameraCenter = Body.get_node("CameraCenter")
	
	CameraCenter.InCameraNode = false
	AcceptParentPos(CameraCenter, Placementnode)

func IgnoreParentPos(CameraCenter: CameraCenterComponent) -> void:
	CameraCenter.top_level = true
	CameraCenter.global_position = CameraCenter.get_parent().global_position

func AcceptParentPos(CameraCenter: CameraCenterComponent, Placement: PlacementNode) -> void:
	CameraCenter.top_level = false
	CameraCenter.global_position = Placement.global_position
