extends Control

onready var bar = $BarOver
onready var bar_under = $BarUnder
onready var update_tween = $UpdateTween
onready var pulse_tween = $PulseTween
export var max_health = 100
export var safe_color: Color = Color.green
export var caution_color: Color = Color.yellow
export var danger_color: Color = Color.red
export var pulse_color: Color = Color.darkred

export var will_pluse : bool = false 

func _on_health_update(amount):
	bar.value = amount
	update_tween.interpolate_property(bar_under, 'value', bar_under.value, amount, 0.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	update_tween.start()
	_assign_color(bar.value)
	
func _on_max_health(amount):
	bar.value = amount
	bar_under.value = max_health
	_assign_color(amount)

func _assign_color(hp):
	if hp > 60:
		pulse_tween.set_active(false)
		bar.tint_progress = safe_color
	elif hp > 30:
		pulse_tween.set_active(false)
		bar.tint_progress = caution_color
	else:
		if will_pluse:
			pulse_tween.interpolate_property(bar, 'tint_progress', pulse_color, danger_color, 1.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
			pulse_tween.start()
		else:
			pulse_tween.set_active(false)
			bar.tint_progress = danger_color
	
