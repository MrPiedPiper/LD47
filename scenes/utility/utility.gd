extends Node2D

var money = 0
var score = 0
var high_score = 0
var is_first_time = true

func save_data():
	var save_file = File.new()
	save_file.open("user://ld47.save",File.WRITE)
	var save_dict = {"high_score":high_score,"is_first_time":is_first_time}
	save_file.store_line(to_json(save_dict))
	save_file.close()

func load_data():
	var save_file = File.new()
	if not save_file.file_exists("user://ld47.save"):
		return 
	save_file.open("user://ld47_high_score.save",File.READ)
	var data = parse_json(save_file.get_line())
	var new_high_score = data["high_score"]
	if new_high_score != null and new_high_score > 0:
		high_score = new_high_score
	is_first_time = data["is_first_time"]

func delete_data():
	var save_file = File.new()
	if save_file.file_exists("user://ld47.save"):
		var dir = Directory.new()
		dir.remove("user://ld47_high_score.save")
