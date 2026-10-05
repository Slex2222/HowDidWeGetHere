@tool
extends Control
class_name CameraSetter

var OffsetNode = preload("uid://b1m3eljxap47h")
var BorderNode = preload("uid://djk5cvn41eung")
var CenterPointNode = preload("uid://bk1xjrysln3en")


@onready var OffsetButton: Button = $"Left Pannel/OffsetButton"
@onready var CenterPointButton: Button = $"Middle Pannel/CenterPointButton"
@onready var BorderButton: Button = $"Right Pannel/BorderButton"


func _ready() -> void:
	OffsetButton.pressed.connect(OffsetButtonPressed)
	BorderButton.pressed.connect(BorderButtonPressed)
	CenterPointButton.pressed.connect(CenterPointButtonPressed)

func OffsetButtonPressed() -> void:
	CreateCustemCameraNode(OffsetNode, "OffsetNodes")

func BorderButtonPressed() -> void:
	CreateCustemCameraNode(BorderNode, "CenterPointNodes")

func CenterPointButtonPressed() -> void:
	CreateCustemCameraNode(CenterPointNode, "BorderNodes")

func FindScreenCenter():
	var Viewport2D = EditorInterface.get_editor_viewport_2d()
	var Transforms = Viewport2D.global_canvas_transform
	
	var Center = Transforms.affine_inverse() * (Viewport2D.get_visible_rect().size / 2)
	
	return Center

func CreateCustemCameraNode(CustemCameraNode: PackedScene, NodeType: String) -> void:
	var SceneRoot = EditorInterface.get_edited_scene_root()
	if !SceneRoot: return
	
	var OffsetNodes = SceneRoot.find_child(NodeType, true, false)
	if !OffsetNodes: return
	
	var CustemCameraInstance = CustemCameraNode.instantiate()
	OffsetNodes.add_child(CustemCameraInstance)
		
	CustemCameraInstance.global_position = FindScreenCenter()
	CustemCameraInstance.owner = SceneRoot
