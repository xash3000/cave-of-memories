extends Node2D

export var next_level: PackedScene

func _on_next_pressed():
	get_tree().change_scene_to(next_level)

