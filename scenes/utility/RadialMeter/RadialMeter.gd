extends Control

onready var meter = $Meter
onready var bar = $Meter/CenterContainer/MarginContainer/Bar
	
func set_percent(percent):
	var rot = clamp(180 * (percent/100),0,180)
	bar.rect_rotation = rot - 180
