extends Area2D

@export var on_load:bool

var tween:Tween
var tutorial_image:Sprite2D


func _ready() -> void:
	if on_load:
		get_parent().connect("auto_reveal", reveal_now)
	tutorial_image = get_child(0)
	tutorial_image.modulate.a = 0

func reveal_now():
	reveal_tutorial()

func _on_body_entered(_body) -> void:
	reveal_tutorial()
	
func _on_body_exited(_body) -> void:
	hide_tutorial()

	
func reveal_tutorial():
	tween = create_tween()
	tween.tween_property(tutorial_image, "modulate:a", 1.0, 3)

func hide_tutorial():
	tween = create_tween()
	tween.tween_property(tutorial_image, "modulate:a", 0.0, 3)
	
