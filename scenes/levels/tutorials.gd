extends Node2D

signal auto_reveal
var check:bool = true
@onready var directions:Array = [$up,$down,$left,$right]
var tween:Tween

func _process(_delta) -> void:
	if check:
		if $"../Player".can_move:
			auto_reveal.emit()
			check = false
	else:
		return



func _on_tutorial_fade_body_exited(body: Node2D) -> void:
	for direction in directions:
		tween = create_tween()
		tween.tween_property(direction, "modulate:a", 0, .5)
	
