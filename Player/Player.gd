extends KinematicBody2D

onready var anim = $AnimatedSprite
onready var bullet_scene = preload('res://Bullet/Bullet.tscn')
export var speed = 128
var velocity = Vector2.ZERO
export var dir = 'right'
var v = {
	"right": Vector2(1, 0),
	"left": Vector2(-1, 0),
	"up": Vector2(0, -1),
	"down": Vector2(0, 1)
}

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed('ui_right'):
		velocity.x = speed
		velocity.y = 0
		anim.play('right')
		dir = 'right'
	elif Input.is_action_pressed('ui_left'):
		velocity.x = -speed
		velocity.y = 0
		anim.play('left')
		dir = 'left'
	elif Input.is_action_pressed('ui_up'):
		velocity.x = 0
		velocity.y = -speed
		anim.play('up')
		dir = 'up'
	elif Input.is_action_pressed('ui_down'):
		velocity.x = 0
		velocity.y = speed
		anim.play('down')
		dir = 'down'
	else:
		velocity = Vector2.ZERO
		anim.play('idle-' + dir)
		
	if Input.is_action_just_pressed('ui_accept'):
		shoot()
		
	velocity = move_and_slide_with_snap(velocity, Vector2(0, -1), Vector2(0, 32))

func shoot() -> void:
	var _v = v[dir]
	var bullet = bullet_scene.instance()
	var lvl = get_tree().get_root().get_node("LevelTemp")
	bullet.init(_v.x, _v.y)
	add_child_below_node(lvl, bullet)


func _on_EnemyDetector_body_entered(body: Node) -> void:
	print(body.filename)
	if body.filename.ends_with("Snake.tscn"):
		print("DYING")
		die()
		
func die():
	get_tree().reload_current_scene()
