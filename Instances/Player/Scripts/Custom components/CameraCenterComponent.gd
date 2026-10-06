class_name CameraCenterComponent extends Area2D

func _ready() -> void:
	area_entered.connect(CameraNodeEntered)

func CameraNodeEntered(Area: Area2D) -> void:
	if Area is OffsetNode:
		var CollisionShape = Area.get_child(0) 
		if CollisionShape is OffsetNodeCollisionShape:
			ApplyOffset(CollisionShape.Offset, CollisionShape.OffsetTransitionSpeed)
	
	if Area is BorderNode:
		var CollisionShape = Area.get_child(0) 
		if CollisionShape is BorderNodeCollisionShape:
			if CollisionShape.OneWay and CollisionShape.OneWayDirectionVector != DetectEntranceSide(Area): return
			
			print("Worked")

func ApplyOffset(Offset: Vector2, OffsetTransitionSpeed: float):
	var CameraTween = create_tween()
	CameraTween.set_ease(Tween.EASE_IN_OUT)
	CameraTween.set_trans(Tween.TRANS_SINE)
	
	var Duration = position.distance_to(Offset) / OffsetTransitionSpeed
	
	CameraTween.tween_property(self, "position", Offset, Duration)

func DetectEntranceSide(Area: Area2D) -> Vector2:
	var Direction = Area.global_position.direction_to(global_position)
	
	if abs(Direction.x) > abs(Direction.y): # detect from which direction the player entered the Area 2d
		if Direction.x < 0:
			Direction = Vector2(-1, 0) #left
		else: 
			Direction = Vector2(1, 0)  #right
	else:
		if Direction.y < 0:
			Direction = Vector2(0, -1) #up
		else:
			Direction = Vector2(0, 1)  #down
	return Direction
