@tool
class_name ChangeStateComponent extends BaseComponent

@export_category("Component Imports")
@export var InputComponent: InputComponent:
	set(value):
		InputComponent = value
		update_configuration_warnings()

func _ready() -> void:
	if Engine.is_editor_hint(): return
	
	InputComponent.FastQuitPressed.connect(QuitGame)

func QuitGame() -> void:
	get_tree().quit()

func _get_configuration_warnings() -> PackedStringArray:
	var Warnings: PackedStringArray
	
	if !InputComponent:
		Warnings.append("Need a Input Component to function")
	
	return Warnings
