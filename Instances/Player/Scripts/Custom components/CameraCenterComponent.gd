class_name CameraCenterComponent extends Area2D

@onready var Player: CharacterBody2D = get_parent()

var LastPos: Vector2
var CurrentPos: Vector2

var BorderOffset: Vector2 = Vector2(0, 0)

var CameraTween: Tween

var PlayerInBorder: bool
var PlayerMovement: Vector2
var EntranceSide: Vector2 = Vector2.ZERO
var OneWayDirectionVector: Vector2  = Vector2.ZERO
var OneWay: bool = false


func _ready() -> void:
	area_entered.connect(CameraNodeEntered)
	area_exited.connect(CameraNodeExited)
	
	LastPos = global_position
	CurrentPos = global_position

func _physics_process(_delta: float) -> void:
	TrackPlayer()
	
	TrackBorderForcedOffset(PlayerMovement, EntranceSide, OneWayDirectionVector, OneWay)

func CameraNodeEntered(Area: Area2D) -> void:
	if Area is OffsetNode:
		var CollisionShape = Area.get_child(0) 
		if CollisionShape is OffsetNodeCollisionShape:
			ApplyOffset(CollisionShape.Offset, CollisionShape.OffsetTransitionSpeed)
	
	if Area is BorderNode:
		var CollisionShape = Area.get_child(0) 
		if CollisionShape is BorderNodeCollisionShape:
			var EntranceSide := DetectEntranceSide()
			if CollisionShape.OneWay and CollisionShape.OneWayDirectionVector != EntranceSide: return
			
			var PlayerMovement := CalcPlayerMovement()
			
			if CollisionShape.OneWay: 
				ApplyBorder(PlayerMovement, EntranceSide, CollisionShape.OneWayDirectionVector, true)
			else: 
				ApplyBorder(PlayerMovement, EntranceSide)

func CameraNodeExited(Area: Area2D) -> void:
	if Area is BorderNode:
		var CollisionShape = Area.get_child(0) 
		if CollisionShape is BorderNodeCollisionShape:
			var ExitSide := DetectEntranceSide() * -1 # make it look for the oposide of the enterance side
			if CollisionShape.OneWay and CollisionShape.OneWayDirectionVector != ExitSide: return
			ApplyOffset(BorderOffset, CollisionShape.BorderRevertSpeed)

func CalcPlayerMovement() -> Vector2:
	return CurrentPos - LastPos

func ApplyBorder(PlayerMovementPara: Vector2, EntranceSidePara: Vector2 = Vector2.ZERO, OneWayDirectionVectorPara: Vector2  = Vector2.ZERO, OneWayPara: bool = false) -> void:
	PlayerInBorder = true
	PlayerMovement = PlayerMovementPara
	EntranceSide = EntranceSidePara
	OneWayDirectionVector = OneWayDirectionVectorPara
	OneWay = OneWayPara

func TrackBorderForcedOffset(PlayerMovement: Vector2, EntranceSide: Vector2 = Vector2.ZERO, OneWayDirectionVector: Vector2  = Vector2.ZERO, OneWay: bool = false) -> void:
	if !PlayerInBorder: return
	
	var Offset: Vector2 = Vector2.ZERO
	if OneWay:
		if OneWayDirectionVector.x * PlayerMovement.x > 0: Offset.x += -PlayerMovement.x 
		if OneWayDirectionVector.y * PlayerMovement.y > 0: Offset.y += -PlayerMovement.y
	
	else:
		if EntranceSide.x * PlayerMovement.x > 0: Offset.x += -PlayerMovement.x 
		if EntranceSide.y * PlayerMovement.y > 0: Offset.y += -PlayerMovement.y 
	
	position += Offset

func ApplyOffset(Offset: Vector2, OffsetTransitionSpeed: float) -> void:
	CameraTween = create_tween()
	CameraTween.set_ease(Tween.EASE_IN_OUT)
	CameraTween.set_trans(Tween.TRANS_SINE)
	
	var Duration = position.distance_to(Offset) / OffsetTransitionSpeed
	
	CameraTween.tween_property(self, "position", Offset, Duration)

func DetectEntranceSide() -> Vector2:
	var Direction = CurrentPos.direction_to(LastPos)
	
	if abs(Direction.x) > abs(Direction.y): # detect from which direction the player entered the Area 2d
		if Direction.x < 0:
			Direction = Vector2(1, 0) #left
		else: 
			Direction = Vector2(-1, 0)  #right
	else:
		if Direction.y < 0:
			Direction = Vector2(0, 1) #up
		else:
			Direction = Vector2(0, -1)  #down
	return Direction

func TrackPlayer() -> void:
	LastPos = CurrentPos
	CurrentPos = global_position
