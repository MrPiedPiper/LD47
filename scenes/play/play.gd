extends Node2D

onready var front_enemies = $EnemiesFront
onready var back_enemies = $EnemiesBack
onready var play_ui = $UI/PlayUI

var time = 30

func _ready():
	Utility.score = 0

func _process(delta):
	$Sun.rotation_degrees += 180*delta/time

func _on_Enemy_move_to_back(enemy:Node2D):
	enemy.get_parent().remove_child(enemy)
	back_enemies.add_child(enemy)


func _on_Enemy_move_to_front(enemy):
	enemy.get_parent().remove_child(enemy)
	front_enemies.add_child(enemy)


func _on_PlayerChicken_scored(score):
	Utility.score += score
	play_ui.set_score(Utility.score)
