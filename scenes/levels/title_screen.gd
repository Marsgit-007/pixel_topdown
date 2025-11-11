extends CanvasLayer
var tween = Tween
@onready var button: Button = $Control/Button
@onready var sprite_2d: Sprite2D = $Control/Sprite2D
@onready var color_rect: ColorRect = $Control/ColorRect


func _ready() -> void:
	sprite_2d.position = Vector2(160,300)
	button.modulate.a = 0
	color_rect.color = Color.BLACK
	tween = create_tween()
	tween.tween_property(sprite_2d, "position", Vector2(160,250), 4)
	tween.parallel()
	tween.tween_property(color_rect, "color", Color(0,0,.13),4)
	tween.tween_property(button, "modulate:a", 1, 4)


func _process(delta: float) -> void:
	sprite_2d.rotation += 1*delta
	


func _on_button_pressed() -> void:
	TransitionLayer.change_scene("res://scenes/levels/grassworld.tscn")
