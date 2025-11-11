extends Path2D

func _process(delta: float) -> void:
	$PathFollow2D.progress_ratio +=.1*delta
