extends Control

signal play_game_pressed

func _on_LetsRollButton_button_up():
	emit_signal("play_game_pressed")
