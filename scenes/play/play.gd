extends Node2D

onready var front_enemies = $EnemiesFront
onready var back_enemies = $EnemiesBack

func _on_Enemy_move_to_back(enemy:Node2D):
	print("moving to back")
	enemy.get_parent().remove_child(enemy)
	back_enemies.add_child(enemy)


func _on_Enemy_move_to_front(enemy):
	print("moving to front")
	enemy.get_parent().remove_child(enemy)
	front_enemies.add_child(enemy)
