@tool
class_name VelocityComponent
extends BaseComponent

@export_category("Movement Specifics")
@export_range(0.0, 500.0, 1.0) var Speed: float = 150.0

@export_category("Object Imports")
@export var SelectedMoveableObject: CharacterBody2D:
	set(value):
		SelectedMoveableObject = value
		update_configuration_warnings()


@export_category("Component Imports")
@export var InputComponent: InputComponent:
	set(value):
		InputComponent = value
		update_configuration_warnings()

@export var NavigationComponent: NavigationComponent:
	set(value):
		NavigationComponent = value
		update_configuration_warnings()

func _process(_delta: float) -> void:
	if Engine.is_editor_hint(): return
	MovementCaller()
	
	SelectedMoveableObject.move_and_slide()

func MovementCaller() -> void:
	if InputComponent:
		Movement(Speed, InputComponent.MovementDirection)

func Movement(ObjectSpeed: float, Direction: Vector2) -> void:
	SelectedMoveableObject.velocity = ObjectSpeed * Direction 

func _get_configuration_warnings() -> PackedStringArray:
	var Warnings: PackedStringArray
	
	if !InputComponent and !NavigationComponent:
		Warnings.append("Need a Input or Navigation Component to function")
	
	if !SelectedMoveableObject:
		Warnings.append("Need a Moveable Object to function")
	
	return Warnings
