extends Node

@onready var ScoreLabel: Label = $Label

var Score = 0

func _ready() -> void:
	var StoredScore = JavaScriptBridge.eval("window.localstorage.getItem('Score')")
	if StoredScore:
		ScoreLabel.text = StoredScore
		Score = StoredScore

func OnAddPressed() -> void:
	Score += 1
	ScoreLabel.text = str(Score)


func OnSavePressed() -> void:
	JavaScriptBridge.eval("window.localStorage.setItem('Score', '{Score}')")
