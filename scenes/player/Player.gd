extends Node2D

enum TYPE {
	DEFAULT,
	HANDS,
	STRETCH
}

var type = TYPE.DEFAULT

func _input(event):
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed == true:
		print("smack!")
		clicked(event.position)

func clicked(pos):
	pass




