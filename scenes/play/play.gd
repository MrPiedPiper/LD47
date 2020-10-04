extends Node2D

onready var front_enemies = $EnemiesFront
onready var back_enemies = $EnemiesBack
onready var play_ui = $UI/PlayUI

var start_time = 60
var time = start_time
var elapsed = 0

func _ready():
	$EnemySpawner.spawn_random_wave(1)
	Utility.score = 0

func _process(delta):
	$Sun.rotation_degrees += 180*delta/start_time
	time -= delta
	elapsed += delta

func _on_Enemy_move_to_back(enemy:Node2D):
	enemy.get_parent().remove_child(enemy)
	back_enemies.add_child(enemy)


func _on_Enemy_move_to_front(enemy):
	enemy.get_parent().remove_child(enemy)
	front_enemies.add_child(enemy)


func _on_PlayerChicken_scored(score):
	Utility.score += score
	play_ui.set_score(Utility.score)

func _on_EnemySpawner_wave_complete():
	$EnemySpawner.spawn_random_wave(elapsed)
