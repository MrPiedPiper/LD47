extends Control

signal play_game_pressed
signal how_to_play_pressed

onready var last_score_display = $MarginContainer/VBoxContainer/HBoxContainer/CenterContainer/MarginContainer/PanelContainer/HBoxContainer/VBoxContainer/ThreeNumberDisplayLast
onready var high_score_display = $MarginContainer/VBoxContainer/HBoxContainer/CenterContainer/MarginContainer/PanelContainer/HBoxContainer/VBoxContainer/ThreeNumberDisplayHigh

func _on_LetsRollButton_button_up():
	emit_signal("play_game_pressed")

func update_score():
	last_score_display.set_numbers(Utility.score)
	high_score_display.set_numbers(Utility.high_score)


func _on_FullScreenButton_button_up():
	#Thanks to Calinou from https://godotengine.org/qa/28425/how-to-toggle-fullscreen-from-code
	OS.window_fullscreen = !OS.window_fullscreen

func _on_How_To_Play_button_up():
	emit_signal("how_to_play_pressed")
