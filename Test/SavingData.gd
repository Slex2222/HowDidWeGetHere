extends Node

@onready var ScoreLabel: Label = $Label

var Score = 0

func _ready() -> void:
	Score = JavaScriptBridge.eval("window.localstorage.getItem('Score')")
	if Score:
		ScoreLabel.text = Score

func OnAddPressed() -> void:
	Score += 1


func OnSavePressed() -> void:
	JavaScriptBridge.eval("window.localStorage.setItem('Score', '{Score}')")
