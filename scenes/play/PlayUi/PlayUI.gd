extends Control

onready var score_texture_1 = $VBoxContainer/PanelContainer/MarginContainer/HBoxContainer/TextureRectScore1
onready var score_texture_2 = $VBoxContainer/PanelContainer/MarginContainer/HBoxContainer/TextureRectScore2
onready var score_texture_3 = $VBoxContainer/PanelContainer/MarginContainer/HBoxContainer/TextureRectScore3

var numbers = []

func _ready():
	for i in range(0,9+1):
		var new_number = load("res://Art/ui/numbers.png")
		var new_image = AtlasTexture.new()
		new_image.atlas = new_number
		new_image.region = Rect2(8*i,0,8,8)
		numbers.append(new_image)
#	set_score(64)

func set_score(new_score:int):
	var score_string = ""
	if new_score > 999:
		score_string = "999"
	else:
		score_string = str(new_score)
	while score_string.length() < 3:
		score_string = "0"+score_string
	score_texture_1.texture = numbers[int(score_string[0])]
	score_texture_2.texture = numbers[int(score_string[1])]
	score_texture_3.texture = numbers[int(score_string[2])]
