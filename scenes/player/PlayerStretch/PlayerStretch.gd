extends "res://scenes/player/Player.gd"

export var stretch_base_pos = Vector2(0,0)
export var stretch_default_pos = Vector2(0,0)

onready var stretch = $Stretchie/Stretch
onready var end = $Stretchie/End
onready var stretch_timer = $StretchTimer

func _ready():
	type = TYPE.STRETCH
	stretch.position = stretch_base_pos
	stretch_to(stretch_default_pos)

func clicked(pos):
	stretch_to(pos)
	stretch_timer.start()

func stretch_to(pos):
	end.global_position = pos
	var distance = stretch_base_pos.distance_to(end.position)
	stretch.rotation = stretch.position.angle_to_point(end.position)-PI/2
	stretch.scale.y = distance/stretch.get_rect().size.y

func _on_StretchTimer_timeout():
	stretch_to(stretch_default_pos)






