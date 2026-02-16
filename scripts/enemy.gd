extends CharacterBody3D

var hp: float = 50
var speed: float = 3.0
var attack_damage: float = 5
var attack_cooldown: float = 1.0
var attack_timer: float = 0

func _ready():
	add_to_group("enemies")

func _physics_process(delta):
	attack_timer -= delta
	var players = get_tree().get_nodes_in_group("players")
	if players.size() > 0:
		var target = players[0]
		var direction = (target.global_position - global_position).normalized()
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		
		if global_position.distance_to(target.global_position) < 2.0 and attack_timer <= 0:
			target.take_damage(attack_damage)
			attack_timer = attack_cooldown
	
	move_and_slide()

func take_damage(amount: float):
	hp -= amount
	if hp <= 0:
		die()

func die():
	if randf() < 0.3:
		spawn_item()
	queue_free()

func spawn_item():
	var item_scene = preload("res://scenes/item.tscn")
	var item = item_scene.instantiate()
	item.global_position = global_position
	get_parent().add_child(item)
