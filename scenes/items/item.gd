extends Area2D
@export var data:ItemInfo

var tween:Tween

func _ready() -> void:
	$Sprite2D.texture = data.icon
	tween = create_tween()
	tween.set_loops()
	tween.tween_property($Sprite2D, "position", Vector2(0,4), .5)
	tween.parallel().tween_property($Shadow, "self_modulate:a", 0.79, .5)
	tween.tween_property($Sprite2D, "position", Vector2(0,0), .5)
	tween.parallel().tween_property($Shadow, "self_modulate:a", 0.29, .5)
	
	


func _on_body_entered(body) -> void:
	Inventory.update_items(data, data.amount)
	queue_free()
		
