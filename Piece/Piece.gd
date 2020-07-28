extends KinematicBody2D

export var id = '0'
export(Texture) var asset setget my_func

func my_func(tex):
	asset = tex
	if Engine.editor_hint:
		get_node("Sprite").texture = asset

func _ready():
	get_node("Sprite").texture = asset
