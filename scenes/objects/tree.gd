extends StaticBody2D
var destructible
var health:int = 30
var tween:Tween
var tween2:Tween
var leaves_finished:bool
var original_color:Color
var wood
@onready var animation:AnimatedSprite2D = $AnimatedSprite2D
@onready var wood_scene:PackedScene = preload("res://scenes/items/item.tscn")

func _on_player_detection_body_entered(body) -> void:
	body.z_index = 1



func _on_player_detection_body_exited(body) -> void:
	body.z_index = 0

func destroy(context:AttackInfo):
	animation.play()
	tween2 = create_tween()
	original_color = animation.self_modulate
	tween2.tween_property(animation, "self_modulate", Color.RED, 0.2)
	tween2.tween_property(animation, "self_modulate", original_color, 0.2)
	
	leaves()
	health -= context.damage
	if health <= 0:
		wood = wood_scene.instantiate()
		wood.data = load("res://resources/items/wood.tres") as ItemInfo
		wood.global_position = Vector2(global_position.x, global_position.y+50)
		$"../items".add_child(wood)
		queue_free()

		
func leaves():
	if not leaves_finished:
		$leaves.visible = true
		leaves_finished = true
		tween = create_tween()
		tween.tween_property($leaves, "position", Vector2(-10,53), 3)
		$Timer.start()
		tween.tween_property($leaves, "modulate", Color.TRANSPARENT, 2)
		await tween.finished
		$leaves.queue_free()
	else:
		pass
