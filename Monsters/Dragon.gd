extends 'res://Monsters/monster.gd'

onready var bullet_scene = preload('res://Bullet/EnemyBullet.tscn')

export var bullet_timer: float = 1

export var dir = 'left'
var _v = {
	"right": Vector2(1, 0),
	"left": Vector2(-1, 0),
	"up": Vector2(0, -1),
	"down": Vector2(0, 1)
}

func _ready() -> void:
	damage = 40
	$BulletTimer.wait_time = bullet_timer


func _on_BulletTimer_timeout() -> void:
	var bullet = bullet_scene.instance()
	# maybe i should refactor this later :3
	var vv = _v[dir]
	bullet.init(vv.x, vv.y)
	bullet.set_as_toplevel(true)
	bullet.position = position
	add_child(bullet)
