extends CanvasLayer


func _on_button_pressed() -> void:
	Inventory.consumables["health"] = 100
	TransitionLayer.change_scene("res://scenes/levels/grassworld.tscn")
	
