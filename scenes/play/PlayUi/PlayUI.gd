extends Control

onready var score_display = $VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/ThreeNumberDisplayScore
onready var high_score_display = $VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/ThreeNumberDisplayHighScore

onready var bar_fill = $VBoxContainer/CenterContainer/MarginContainer/MarginContainer/FillTextureRect

func set_bar_percentage(perc:float):
	var col = $TextureRect.modulate
	if perc > 0.5:
		col.a = (perc-0.5)*2
		if perc >= 1:
			col.a = 0
	else:
		col.a = 0
	$TextureRect.modulate = col
	$VBoxContainer/MarginContainer/RadialMeter.set_percent(perc*100)
#	bar_fill.material.set_shader_param("fill",perc)
#	if perc > 0.64: 
#		if !$AnimationPlayer.is_playing():
#			$AnimationPlayer.stop(true)
#			$AnimationPlayer.play("Warning")
#	else:
#		$AnimationPlayer.seek(0,true)
#		$AnimationPlayer.stop(true)

func update_score():
	set_score(Utility.score)
	set_high_score(Utility.high_score)

func set_score(new_score:int):
	score_display.set_numbers(new_score)

func set_high_score(new_score:int):
	high_score_display.set_numbers(new_score)
