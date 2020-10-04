extends Node2D

signal wave_complete
signal enemy_spawned

onready var path_left = $Path2DLeft
onready var path_right = $Path2DRight
onready var path_circle = $Path2DCircle
onready var paths = [path_left,path_circle,path_right]

export var max_difficulty = 100

export var node_front:NodePath
export var node_behind:NodePath

export(Array,PackedScene) var enemies = []
var easy_enemies = []
var medium_enemies = []
var hard_enemies = []

var difficulty = 1
var wave = []

var min_cooldown = 0.5
var max_cooldown = 1.5

var is_spawning = false

func _ready():
	for i in enemies:
		var curr = i.instance()
		if curr.difficulty == curr.DIFFICULTY["EASY"]:
			easy_enemies.append(i)
		elif curr.difficulty == curr.DIFFICULTY["MEDIUM"]:
			medium_enemies.append(i)
		elif curr.difficulty == curr.DIFFICULTY["HARD"]:
			hard_enemies.append(i)

func randomize_wave():
	randomize()
	var placeholder = []
	for i in wave:
		var index = 0
		if placeholder.size() > 0:
			index = randi()%placeholder.size()
		placeholder.insert(index,i)
	wave = placeholder

func populate_wave():
	wave = []
	var hat = difficulty
	if hat >= 6:
		if hard_enemies.size() > 0:
			var hard_points = int(hat/2)
			hat -= hard_points
			while hard_points >= 3:
				wave.append(hard_enemies[randi()%hard_enemies.size()])
				hard_points -= 3
			hat += hard_points
	if hat > 4:
		if medium_enemies.size() > 0:
			var medium_points = int(hat/2)
			hat -= medium_points
			while medium_points >= 2:
				wave.append(medium_enemies[randi()%medium_enemies.size()])
				medium_points -= 2
			hat += medium_points
	
	if easy_enemies.size() > 0:
		while hat >= 1:
			wave.append(easy_enemies[randi()%easy_enemies.size()])
			hat -= 1

func spawn_random_wave(diff):
	is_spawning = true
	difficulty = int(min(diff,max_difficulty))
	populate_wave()
	randomize_wave()
	$spawn_cooldown.wait_time = rand_range(min_cooldown,max_cooldown)
	$spawn_cooldown.start()
	return wave

func get_random_path():
	randomize()
	return paths[randi()%3]

func _on_spawn_cooldown_timeout():
	if !is_spawning:
		return
	if wave.size() == 0:
		emit_signal("wave_complete")
		return
	var new_spawn = wave[0].instance()
	wave.remove(0)
	var path = get_random_path()
	new_spawn.path = path
	
	new_spawn.is_looping = true
	
	new_spawn.connect("move_to_front",get_parent(),"_on_Enemy_move_to_front")
	new_spawn.connect("move_to_back",get_parent(),"_on_Enemy_move_to_back")
	
	new_spawn.position = new_spawn.path.curve.get_point_position(0)
	get_node(node_behind).add_child(new_spawn)
	emit_signal("enemy_spawned")
	
	$spawn_cooldown.wait_time = rand_range(min_cooldown,max_cooldown)
	$spawn_cooldown.start()

func stop():
	is_spawning = false
	$spawn_cooldown.stop()
