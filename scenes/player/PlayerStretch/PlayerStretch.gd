extends "res://scenes/player/Player.gd"

onready var stretch = $Stretchie/Stretch
onready var end = $Stretchie/End
onready var stretch_timer = $StretchTimer
onready var stretch_target = $Stretchie/End/StretchTarget

onready var stretch_default_pos = end.global_position

func _ready():
	type = TYPE.STRETCH
	stretch_to(stretch_default_pos)

func clicked(pos):
	stretch_to(pos)
	stretch_timer.start()
	$AnimationPlayer.play("example")

func stretch_to(pos):
	var local_pos = pos - position
	if local_pos.x < 0:
		end.scale.x = -abs(end.scale.x)
	else:
		end.scale.x = abs(end.scale.x)
	end.global_position = pos
	var distance = stretch.global_position.distance_to(stretch_target.global_position)
	stretch.rotation = stretch.global_position.angle_to_point(stretch_target.global_position)-PI/2
	stretch.scale.y = distance/stretch.get_rect().size.y

func _on_StretchTimer_timeout():
	stretch_to(stretch_default_pos)






