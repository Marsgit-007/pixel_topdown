extends Node2D

var fallen:bool = false

func _process(delta: float) -> void:
	if not fallen:
		for leaf in get_children():
			leaf.rotate(2*delta)
	else:
		return

func _on_timer_timeout() -> void:
	fallen = true
