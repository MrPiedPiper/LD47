extends HBoxContainer

var numbers = []

func _ready():
	for i in range(0,9+1):
		var new_number = load("res://Art/ui/numbers.png")
		var new_image = AtlasTexture.new()
		new_image.atlas = new_number
		new_image.region = Rect2(8*i,0,8,8)
		numbers.append(new_image)

func set_numbers(new_numbers):
	var number_string = ""
	if new_numbers > 999:
		number_string = "999"
	else:
		number_string = str(new_numbers)
	while number_string.length() < 3:
		number_string = "0"+number_string
	$Number1.texture = numbers[int(number_string[0])]
	$Number2.texture = numbers[int(number_string[1])]
	$Number3.texture = numbers[int(number_string[2])]
