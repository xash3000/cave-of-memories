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
signal piece(id)
signal health(amount)
signal max_health(amount)
signal mp(amount)
signal max_mp(amount)
var hp = 100
var mp = 100
export var mp_damage = 10
var filling: bool = false

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
		
	velocity = move_and_slide(velocity, Vector2(0, -1))
	position = position.round()

func shoot() -> void:
	if filling:
		return
	mp -= mp_damage
	emit_signal("mp", mp)
	var _v = v[dir]
	var bullet = bullet_scene.instance()
	#var lvl = get_tree().get_root().get_node"BLevelTemp)
	bullet.init(_v.x, _v.y)
	bullet.set_as_toplevel(true)
	bullet.position = position
	add_child(bullet)
	
	if mp < 10:
		fill_mp()

func fill_mp():
	$'UI/mp-note'.visible = true
	filling = true
	
	var t = Timer.new()
	t.set_wait_time(5)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	
	mp = 100
	emit_signal('max_mp', 100)
	$'UI/mp-note'.visible = false
	filling = false

func _on_EnemyDetector_body_entered(body: Node) -> void:
	for enemy in ["Snake.tscn", "Dragon.tscn", "EnemyBullet.tscn"]:
		if body.filename.ends_with(enemy):
			hit(body)

func hit(body):
	hp -= body.get('damage')
	$SFX/hurt.play()
	if hp <= 0:
		die()
	elif hp < 30:
		$SFX/pulse.play()
	emit_signal('health', hp)		
func die():
	get_tree().reload_current_scene()


func _on_PieceDetector_body_entered(body: Node) -> void:
	if body.filename.ends_with('Piece.tscn'):
		body.queue_free()
		$SFX/pickup.play()
		emit_signal('piece', body.get('id'))
	if body.filename.ends_with('Apple.tscn'):
		print(body.filename)
		hp = 100
		mp = 100
		body.queue_free()
		$SFX/pickup.play()
		$SFX/pulse.stop()
		emit_signal('max_health', 100)
		emit_signal('max_mp', 100)
		$'UI/mp-note'.visible = false
		filling = false
