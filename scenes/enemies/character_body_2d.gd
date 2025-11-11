extends CharacterBody2D

var movement_speed: float = 2500.0
var movement_target_position: Vector2
var player
var starting_pos:Vector2
var attack_data = AttackInfo.new()
var health:int = 30
var tween:Tween
var destructible
var bone

@onready var active:bool = false
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var original_color:Color
@onready var bone_scene:PackedScene = preload("res://scenes/items/item.tscn")


func _ready():
	# These values need to be adjusted for the actor's speed
	# and the navigation layout.
	original_color = animation.self_modulate
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0
	starting_pos = position

	# Make sure to not await during _ready.
	#actor_setup.call_deferred()
	attack_data.damage = 10





func _physics_process(delta):
	if active == true:

		set_movement_target(player.position)
		var current_agent_position: Vector2 = global_position
		var next_path_position: Vector2 = navigation_agent.get_next_path_position()

		velocity = current_agent_position.direction_to(next_path_position) * movement_speed*delta
		if velocity.x > 0:
			animation.scale = Vector2(-1,1)
		else:
			animation.scale = Vector2(1,1)
		animation.play("attacking")
		move_and_slide()
	elif position != starting_pos:	
		velocity = position.direction_to(starting_pos) * movement_speed*delta
		move_and_slide()
		animation.play("resting")

	#elif position == starting_pos:
		#print("reached!")
		#animation.play("resting")

func destroy(context:AttackInfo):
	print("destroy!")
	tween = create_tween()
	original_color = animation.self_modulate
	tween.tween_property(animation, "self_modulate", Color.RED, 0.2)
	tween.tween_property(animation, "self_modulate", original_color, 0.2)
	

	health -= context.damage
	if health <= 0:
		bone = bone_scene.instantiate()
		bone.data = load("res://resources/items/bone.tres") as ItemInfo
		bone.global_position = global_position
		owner.owner.get_child(1).add_child(bone)

		queue_free()

		


func _on_area_2d_body_entered(body) -> void:
	active  = true
	player = body




func _on_area_2d_body_exited(body) -> void:
	active = false
	

func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target
