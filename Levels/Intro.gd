extends Node2D

export var level_1: PackedScene

func _on_Start_pressed() -> void:
	get_tree().change_scene_to(level_1)
