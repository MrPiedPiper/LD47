extends "res://scenes/player/Player.gd"

onready var stretch = $Stretchie/Stretch
onready var end = $Stretchie/End
onready var stretch_timer = $StretchTimer
onready var stretch_target = $Stretchie/End/Sprite/StretchTarget

onready var stretch_default_pos = end.global_position

func _ready():
	type = TYPE.STRETCH
	stretch_to(stretch_default_pos)

func clicked(pos):
	stretch_to(pos)
	stretch_timer.start()
<<<<<<< HEAD
#	$AnimationPlayer.play("example")
=======
#	$Stretchie/End/CPUParticles2D.restart()
	$AnimationPlayer.play("example")
>>>>>>> bd78f6223406759652e0090971816788552cac0c

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

func _on_Area2DAttack_area_entered(area):
	print("Hit!")
	if area.owner.is_in_group("enemy"):
		$Stretchie/End/ParticleBurst.burst(area.global_position)
		







