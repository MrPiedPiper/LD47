extends Node2D

signal scored
signal attack_completed
signal killed_bug

enum TYPE {
	DEFAULT,
	HANDS,
	STRETCH
}

var type = TYPE.DEFAULT
export var default_attack:int = 1
var attack = 1

var saved_animation_seek = 0

func _input(event):
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed == true:
		clicked(event.position)

func clicked(pos):
	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	$AnimationPlayer.stop()
	if anim_name == "Attack":
		$AnimationPlayer.play("Idle")
		$AnimationPlayer.seek(saved_animation_seek,true)
		finish_attack()

func finish_attack():
	pass

func hit(enemy,damage):
	if enemy.health - damage <= 0:
		emit_signal("scored",enemy.score)
		emit_signal("killed_bug",enemy)
	enemy.damage(damage)



