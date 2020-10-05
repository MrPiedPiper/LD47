extends Node2D

export var color = Color.white
export var text = "+1"

func _ready():
	$Mobile/Label.text = text
	modulate = color

func delete():
	queue_free()
