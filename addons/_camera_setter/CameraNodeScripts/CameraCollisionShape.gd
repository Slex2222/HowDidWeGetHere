class_name CameraCollisionShape extends CollisionShape2D

## Apply an offset to a camera center node 
func ApplyOffset(CameraCenter: CameraCenterComponent, Offset: Vector2, OffsetTransitionSpeed: float):
	var CameraTween = create_tween()
	CameraTween.set_ease(Tween.EASE_IN_OUT)
	CameraTween.set_trans(Tween.TRANS_SINE)
	
	var Duration = CameraCenter.position.distance_to(Offset) / OffsetTransitionSpeed
	
	CameraTween.tween_property(CameraCenter, "position", Offset, Duration)

## Apply an offset to a camera center node 
func ApplyPosition(CameraCenter: CameraCenterComponent, Position: Vector2, OffsetTransitionSpeed: float):
	var CameraTween = create_tween()
	CameraTween.set_ease(Tween.EASE_IN_OUT)
	CameraTween.set_trans(Tween.TRANS_SINE)
	
	var Duration = CameraCenter.position.distance_to(Position) / OffsetTransitionSpeed
	
	CameraTween.tween_property(CameraCenter, "global_position", Position, Duration)

func SelectShape() -> void:
	if !Engine.is_editor_hint(): return
	
	EditorInterface.edit_node(self)
