extends Area2D

onready var opened = preload('res://Assets/Tiles/open_door.png')
onready var closed = preload('res://Assets/Tiles/closed_door.png')
onready var sprite = $Sprite


func _on_body_entered(body: Node) -> void:
	sprite.set_texture(opened)

func _on_body_exited(body: Node) -> void:
	sprite.set_texture(closed)
