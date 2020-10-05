extends Control

signal done



func _on_HowToPlay_gui_input(event):
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed == true:
		Utility.is_first_time = false
		emit_signal("done")
		queue_free()
