extends Control

onready var bar = $Bar
export var max_health = 100

export var safe_color: Color = Color.green
export var caution_color: Color = Color.yellow
export var  danger_color: Color = Color.red

func _on_health_update(amount):
	bar.value = amount
	
	if amount > 60:
		bar.tint_progress = safe_color
	elif amount > 30:
		bar.tint_progress = caution_color
	else:
		bar.tint_progress = danger_color
	
func _on_max_health():
	bar.value = max_health
