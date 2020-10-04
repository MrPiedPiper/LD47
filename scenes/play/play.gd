extends Node2D

onready var front_enemies = $EnemiesFront
onready var back_enemies = $EnemiesBack
onready var play_ui = $UI/PlayUI

var start_time = 60
var time = start_time
var elapsed = 0

var lose_threshold:float = 10.0

func _ready():
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

func _on_Menu_play_game_pressed():
	$EnemySpawner.spawn_random_wave(1)
	$UI/Menu.hide()
	$UI/PlayUI.show()

func _on_EnemySpawner_enemy_spawned():
	update_bar()

func update_bar():
	var enemy_count = front_enemies.get_child_count() + back_enemies.get_child_count()
	$UI/PlayUI.set_bar_percentage(enemy_count/lose_threshold)

func _on_PlayerChicken_attack_completed():
	update_bar()
