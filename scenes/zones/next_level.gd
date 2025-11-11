extends Area2D

@export var next_level:String


func _on_body_entered(body) -> void:
	TransitionLayer.change_scene(next_level)
