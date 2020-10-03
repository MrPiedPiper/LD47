extends Node2D

onready var burst = load("res://scenes/utility/ParticleBurst/Burst/Burst.tscn")
export var color:Color = Color.white

func _ready():
	$Bursts.modulate = color

func burst(global_pos):
	var new_burst = burst.instance()
	$Bursts.add_child(new_burst)
	new_burst.global_position = global_pos
	print("Made a burst")
