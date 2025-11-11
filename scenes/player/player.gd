extends CharacterBody2D


@export var starting_state:String

@onready var animation:AnimatedSprite2D = $AnimatedSprite2D
@onready var up_right_down_detector:Area2D = $UP_RIGHT_DOWN_detector
@onready var left_detector:Area2D = $LEFT_detector
@onready var can_move:bool = false
@onready var user_interface:PackedScene = preload("res://scenes/UI/ui.tscn")

var speed:int = 4000
var last_direction:String
var attacking:bool
var to_damage:Array
var attack_context:AttackInfo
var vulnerable = true

var HUD



func _physics_process(delta: float) -> void:
	Inventory.player_pos = global_position

	if Input.is_action_just_pressed("pause"):
		$"../Pause".pause_menu()
	if Input.is_action_just_pressed("inventory"):
		$"../InventoryPage".inventory_menu()
	if can_move:
		var direction: Vector2 = Vector2.ZERO
		if attacking:
			return
		
		# Prioritize horizontal movement over vertical to prevent diagonal movement
		if Input.is_action_pressed("left"):
			direction.x = -1
			animation.play("left")
			last_direction = "left"
				
		elif Input.is_action_pressed("right"):
			direction.x = 1
			animation.play("right")
			last_direction = "right"
			
		else:
			# Check vertical movement only if no horizontal input
			if Input.is_action_pressed("up"):
				direction.y = -1
				animation.play("up")
				last_direction = "up"
			elif Input.is_action_pressed("down"):
				direction.y = 1
				animation.play("down")
				last_direction = "down"
			else:
				# Pause animation when no movement
				animation.pause()
		if Input.is_action_just_pressed("attack"):
			attacking = true
			animation.pause()
			animation.play("attack_"+last_direction)
			attack(last_direction)


		
		# Apply movement
		velocity = direction * speed*delta
		move_and_slide()
	else:
		pass

func _ready() -> void:
	# Ensure animations are paused initially
	if starting_state == "awakening":
		animation.play(starting_state)
		await animation.animation_finished
	
	else:
		animation.play(starting_state)
		pass
	can_move = true
	HUD = user_interface.instantiate()
	get_parent().add_child.call_deferred(HUD)
	attacking = false
	animation.connect("animation_finished", animation_finished)
	last_direction = "down"
	
func animation_finished():
	if attacking:
		attacking = false
	else:
		pass
		
func attack(attack_direction):
	match attack_direction:
		"up","down","right":
			to_damage = up_right_down_detector.get_overlapping_bodies()
			print(to_damage)
		"left":
			to_damage = left_detector.get_overlapping_bodies()
	if to_damage.is_empty():
		return
	else:
		for object in to_damage:
			if "destructible" in object:
				attack_context = AttackInfo.new()
				attack_context.damage = 10
				attack_context.knockback_force = 10
				object.destroy(attack_context)

func hit(info:AttackInfo):
	if vulnerable:
		$AnimatedSprite2D.material.set_shader_parameter("clr",Color.RED)
		Inventory.update_items("health", 10)
		$OutlineTimer.start()
		vulnerable = false


func _on_hit_box_body_entered(body) -> void:
	print(body)
	hit(body.attack_data)


func _on_outline_timer_timeout() -> void:
	$AnimatedSprite2D.material.set_shader_parameter("clr",Color.TRANSPARENT)
	vulnerable = true
	


func _on_hit_box_area_entered(area) -> void:
	print(area)
	hit(area.attack_data)
