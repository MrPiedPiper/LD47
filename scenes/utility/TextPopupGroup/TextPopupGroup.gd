extends Node2D

onready var text_popup = load("res://scenes/utility/TextPopupGroup/TextPopup/TextPopup.tscn") 

func spawn_text(new_text:String,new_pos:Vector2,new_color:Color):
	var text = text_popup.instance()
	text.text = new_text
	text.global_position = new_pos
	add_child(text)
	text.set_modulate(new_color)
