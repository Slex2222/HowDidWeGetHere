@tool
extends Control
class_name CameraSetter

var OffsetNode = preload("uid://b1m3eljxap47h")


@onready var OffsetButton: Button = $"Left Pannel/OffsetButton"

func _ready() -> void:
	OffsetButton.pressed.connect(OffsetButtonPressed)

func OffsetButtonPressed() -> void:
	print("test")
	
	var SceneRoot = EditorInterface.get_edited_scene_root()
	if !SceneRoot: return
	
	var OffsetNodes = SceneRoot.find_child("OffsetNodes", true, false)
	if !OffsetNodes: return
	
	var OffsetNodeInstance = OffsetNode.instantiate()
	OffsetNodes.add_child(OffsetNodeInstance)
		
	OffsetNodeInstance.global_position = FindScreenCenter()
	OffsetNodeInstance.owner = SceneRoot


func FindScreenCenter():
	var Viewport2D = EditorInterface.get_editor_viewport_2d()
	var Transforms = Viewport2D.global_canvas_transform
	
	var Center = Transforms.affine_inverse() * (Viewport2D.get_visible_rect().size / 2)
	
	return Center
