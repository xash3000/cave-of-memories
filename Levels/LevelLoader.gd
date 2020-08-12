extends Node2D

const save_path = "user://save.txt"
var next_scene = "res://Levels/Intro.tscn"

func _ready() -> void:
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open(save_path, File.READ)
		if error == OK:
			var data = file.get_var()
			next_scene = data["last_scene"]
			file.close()
	get_tree().change_scene(next_scene)
