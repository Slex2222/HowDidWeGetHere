@tool
extends EditorPlugin

var EditorPanel: Control

func _enter_tree() -> void:
	EditorPanel = preload("res://addons/_camera_setter/CameraSetter/CameraSetterPanel.tscn").instantiate()
	
	add_control_to_bottom_panel(EditorPanel, "CameraSetterPanel")
	
	

func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	remove_control_from_bottom_panel(EditorPanel)
	
	EditorPanel.queue_free()
