extends CharacterBody2D


@onready var animation:AnimatedSprite2D =  $AnimatedSprite2D
@onready var snowball_scene:PackedScene = preload("res://scenes/enemies/snowball.tscn")
@onready var shoot_timer: Timer = $ShootTimer
@onready var original_color:Color
var tween:Tween
var attack_data = AttackInfo.new()
var attack_mode:bool = false
var shoot:bool = false
var snowball
var right:bool
var destructible
var health:int = 70

func _ready() -> void:
	attack_data.damage = 10

func _on_notice_area_body_entered(body) -> void:

	tween = create_tween()
	tween.tween_property($"../Player/Camera2D", "zoom", Vector2(0.5, 0.5), 3)
	animation.play("awake")

func _on_attack_area_body_entered(body) -> void:
	shoot_timer.start()
	
	
func _on_shoot_timer_timeout() -> void:
	throw_snowball(Inventory.player_pos)
	
func throw_snowball(target):
	if target.x >= 165:
		right = true
	else:
		right = false
	snowball = snowball_scene.instantiate()
	if right:
		$tail.add_child(snowball)
	else:
		$flipper.add_child(snowball)
	snowball.fire(target)
	animation.play("attack")

func destroy(context:AttackInfo):
	print("destroy!")
	tween = create_tween()
	original_color = animation.self_modulate
	tween.tween_property(animation, "self_modulate", Color.RED, 0.2)
	tween.tween_property(animation, "self_modulate", original_color, 0.2)
	health -= context.damage
	if health <= 0:
		$"../Igloo".show()
		queue_free()
	
	
