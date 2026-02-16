extends CharacterBody3D

@export var player_id: int = 0
@export var is_ai: bool = false
@export var character_class: int = 0

var max_hp: float = 100
var hp: float = 100
var max_mp: float = 100
var mp: float = 100
var speed: float = 5.0
var attack_damage: float = 10

func _ready():
	setup_class()

func setup_class():
	match character_class:
		GameManager.CharacterClass.WARRIOR:
			max_hp = 150
			attack_damage = 20
			speed = 5.0
		GameManager.CharacterClass.MAGE:
			max_hp = 80
			max_mp = 150
			attack_damage = 15
			speed = 4.0
		GameManager.CharacterClass.HUNTER:
			max_hp = 100
			attack_damage = 12
			speed = 5.5
		GameManager.CharacterClass.PRIEST:
			max_hp = 90
			max_mp = 120
			attack_damage = 8
			speed = 5.0
	hp = max_hp
	mp = max_mp

func _physics_process(delta):
	if is_ai:
		ai_behavior(delta)
	else:
		player_input(delta)
	move_and_slide()

func player_input(delta):
	var input_prefix = "p1_" if player_id == 0 else "p2_"
	var input_dir = Vector2(
		Input.get_action_strength(input_prefix + "right") - Input.get_action_strength(input_prefix + "left"),
		Input.get_action_strength(input_prefix + "down") - Input.get_action_strength(input_prefix + "up")
	)
	velocity.x = input_dir.x * speed
	velocity.z = input_dir.y * speed

func ai_behavior(delta):
	var enemies = get_tree().get_nodes_in_group("enemies")
	if enemies.size() > 0:
		var target = enemies[0]
		var direction = (target.global_position - global_position).normalized()
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed

func take_damage(amount: float):
	hp -= amount
	if hp <= 0:
		die()

func heal(amount: float):
	hp = min(hp + amount, max_hp)

func restore_mp(amount: float):
	mp = min(mp + amount, max_mp)

func die():
	queue_free()
