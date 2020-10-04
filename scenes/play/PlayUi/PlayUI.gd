extends Control

onready var score_texture_1 = $VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/TextureRectScore1
onready var score_texture_2 = $VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/TextureRectScore2
onready var score_texture_3 = $VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/TextureRectScore3

onready var high_score_texture_1 = $VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer2/TextureRectScore1
onready var high_score_texture_2 = $VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer2/TextureRectScore2
onready var high_score_texture_3 = $VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer2/TextureRectScore3

onready var bar_fill = $VBoxContainer/CenterContainer/MarginContainer/MarginContainer/FillTextureRect

var numbers = []

func _ready():
	for i in range(0,9+1):
		var new_number = load("res://Art/ui/numbers.png")
		var new_image = AtlasTexture.new()
		new_image.atlas = new_number
		new_image.region = Rect2(8*i,0,8,8)
		numbers.append(new_image)

func set_bar_percentage(perc:float):
	bar_fill.material.set_shader_param("fill",perc)
	if perc > 0.64: 
		if !$AnimationPlayer.is_playing():
			$AnimationPlayer.stop(true)
			$AnimationPlayer.play("Warning")
	else:
		$AnimationPlayer.seek(0,true)
		$AnimationPlayer.stop(true)

func update_score():
	set_score(Utility.score)
	set_high_score(Utility.high_score)

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

func set_high_score(new_score:int):
	var score_string = ""
	if new_score > 999:
		score_string = "999"
	else:
		score_string = str(new_score)
	while score_string.length() < 3:
		score_string = "0"+score_string
	high_score_texture_1.texture = numbers[int(score_string[0])]
	high_score_texture_2.texture = numbers[int(score_string[1])]
	high_score_texture_3.texture = numbers[int(score_string[2])]
