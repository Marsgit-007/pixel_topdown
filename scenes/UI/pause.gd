extends CanvasLayer

func pause_menu():
	get_tree().paused = true
	get_child(0).process_mode = Node.PROCESS_MODE_INHERIT

	show()
	


func _on_button_pressed() -> void:
	hide()
	get_child(0).process_mode = Node.PROCESS_MODE_DISABLED
	get_tree().paused = false


func _on_button_2_pressed() -> void:
	hide()
	get_tree().paused = false
	TransitionLayer.change_scene("res://scenes/levels/title_screen.tscn")


func _on_button_3_pressed() -> void:
	get_tree().free()
