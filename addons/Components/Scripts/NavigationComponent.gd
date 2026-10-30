@tool
class_name NavigationComponent extends BaseComponent



func _enter_tree() -> void:
	if get_child_count() == 0:
		AddLine2D()

func AddLine2D():
	var Path = Path2D.new()
	Path.name = "Path"
	Path.curve = Curve2D.new()
	
	add_child(Path)
	
	if Engine.is_editor_hint():
		Path.owner = get_tree().edited_scene_root
