@tool
class_name ShadowComponent extends Node2D

@export_range(0.0, 1.0, 0.01) var ShadowAlpha: float = 1.0:
	set(value):
		ShadowAlpha = value
		UpdateShadow()

@export var ShadowSprite: Sprite2D

var LastShadowAlpha: float = -1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UpdateShadow()


func _process(_delta: float) -> void:
	if ShadowAlpha != LastShadowAlpha:
		LastShadowAlpha = ShadowAlpha
		UpdateShadow()

func UpdateShadow():
	if !ShadowSprite or !ShadowSprite.material: return
	
	ShadowSprite.material.set_shader_parameter("AlphaValue", ShadowAlpha)
