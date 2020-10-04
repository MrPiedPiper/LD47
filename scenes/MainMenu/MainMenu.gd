extends Control

signal play_game_pressed

onready var score_label = $MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/PanelContainer/HBoxContainer/Label2

func _on_LetsRollButton_button_up():
	emit_signal("play_game_pressed")

func update_score():
	var score_string = str(Utility.score)
	while score_string.length() > 3:
		score_string = "0"+score_string
	var high_score_string = str(Utility.high_score)
	while high_score_string.length() > 3:
		high_score_string = "0"+high_score_string
	score_label.text = score_string+"\n"+high_score_string
