extends Area2D
var direction:Vector2
var speed:int = 200
var moving:bool = false
var attack_data = AttackInfo.new()

func _ready() -> void:
	attack_data.damage = 10


func fire(target):
	moving = true
	direction = target-global_position

func _physics_process(delta) -> void:
	if moving:
		position += direction.normalized()*speed*delta
	else:
		return
	
