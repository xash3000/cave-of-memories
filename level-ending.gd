extends Node2D

export var next_level: PackedScene

var save_path = "user://save.txt"

func _ready() -> void:
	var data = {
		"last_scene": get_tree().current_scene.filename
	}
	
	var file = File.new()
	var error = file.open(save_path, File.WRITE)
	
	if error == OK:
		file.store_var(data)
		file.close()
	
func _on_next_pressed():
	get_tree().change_scene_to(next_level)
	
func _on_restart_pressed():
	get_tree().change_scene("res://Levels/Intro.tscn")

