extends Node2D

var money = 0
var score = 0
var high_score = 0

func save_high_score():
	var save_file = File.new()
	save_file.open("user://ld47_high_score.save",File.WRITE)
	var save_dict = {"high_score":high_score}
	save_file.store_line(to_json(save_dict))
	save_file.close()

func load_high_score():
	var save_file = File.new()
	if not save_file.file_exists("user://ld47_high_score.save"):
		return 
	save_file.open("user://ld47_high_score.save",File.READ)
	var data = parse_json(save_file.get_line())
	var new_high_score = data["high_score"]
	if new_high_score != null and new_high_score > 0:
		high_score = new_high_score

func delete_high_score():
	var save_file = File.new()
	if save_file.file_exists("user://ld47_high_score.save"):
		var dir = Directory.new()
		dir.remove("user://ld47_high_score.save")
