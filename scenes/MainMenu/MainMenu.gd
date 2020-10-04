extends Control

signal play_game_pressed

onready var last_score_display = $MarginContainer/VBoxContainer/HBoxContainer/CenterContainer/MarginContainer/PanelContainer/HBoxContainer/VBoxContainer/ThreeNumberDisplayLast
onready var high_score_display = $MarginContainer/VBoxContainer/HBoxContainer/CenterContainer/MarginContainer/PanelContainer/HBoxContainer/VBoxContainer/ThreeNumberDisplayHigh

func _on_LetsRollButton_button_up():
	emit_signal("play_game_pressed")

func update_score():
	last_score_display.set_numbers(Utility.score)
	high_score_display.set_numbers(Utility.high_score)
