extends Node

@onready var ScoreLabel: Label = $Label

var Score = 0

func _ready() -> void:
	var StoredScore = JavaScriptBridge.eval("localStorage.getItem('Score')")

	if StoredScore != null:
		Score = int(StoredScore)
		ScoreLabel.text = str(Score)


func OnAddPressed() -> void:
	Score += 1
	ScoreLabel.text = str(Score)


func OnSavePressed() -> void:
	JavaScriptBridge.eval("window.localStorage.setItem('Score', '" + str(Score) + "')")
