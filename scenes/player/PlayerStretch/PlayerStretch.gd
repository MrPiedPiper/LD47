extends "res://scenes/player/Player.gd"

onready var stretch = $Stretchie/Stretch
onready var end = $Stretchie/End
onready var stretch_target = $Stretchie/End/Sprite/StretchTarget

onready var stretch_default_pos = end.global_position

func _ready():
	type = TYPE.STRETCH
	stretch_to(stretch_default_pos,false)

func _process(delta):
	stretch_to(end.global_position,false)

func clicked(pos):
	stretch_to(pos,true)
	if $AnimationPlayer.current_animation == "Idle":
		saved_animation_seek = $AnimationPlayer.current_animation_position
	$AnimationPlayer.play("Attack")

func stretch_to(pos,can_flip):
	var local_pos = pos - position
	if local_pos.x < 0:
		end.scale.x = -abs(end.scale.x)
	else:
		end.scale.x = abs(end.scale.x)
	end.global_position = pos
	var distance = stretch.global_position.distance_to(stretch_target.global_position)
	stretch.rotation = stretch.global_position.angle_to_point(stretch_target.global_position)-PI/2
	stretch.scale.y = distance/stretch.get_rect().size.y

func finish_attack():
	stretch_to(stretch_default_pos,true)
	emit_signal("attack_completed")

func _on_Area2DAttack_area_entered(area):
	if area.owner.is_in_group("enemy"):
		$Stretchie/End/ParticleBurst.burst(area.global_position)
		hit(area.owner,attack)
		







