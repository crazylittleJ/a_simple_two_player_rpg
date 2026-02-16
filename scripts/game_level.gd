extends Node3D

@export var enemy_count: int = 10
@export var chest_count: int = 5

func _ready():
	spawn_players()
	spawn_enemies()
	spawn_chests()

func spawn_players():
	var player_scene = preload("res://scenes/player.tscn")
	for i in range(GameManager.player_count):
		var player = player_scene.instantiate()
		player.player_id = i
		player.character_class = GameManager.selected_classes[i]
		player.global_position = Vector3(i * 2, 1, 0)
		add_child(player)
	
	if GameManager.ai_enabled:
		var ai_player = player_scene.instantiate()
		ai_player.is_ai = true
		ai_player.character_class = GameManager.selected_classes[-1]
		ai_player.global_position = Vector3(GameManager.player_count * 2, 1, 0)
		add_child(ai_player)

func spawn_enemies():
	var enemy_scene = preload("res://scenes/enemy.tscn")
	for i in range(enemy_count):
		var enemy = enemy_scene.instantiate()
		var angle = (i / float(enemy_count)) * TAU
		enemy.global_position = Vector3(cos(angle) * 15, 1, sin(angle) * 15)
		add_child(enemy)

func spawn_chests():
	var chest_scene = preload("res://scenes/chest.tscn")
	for i in range(chest_count):
		var chest = chest_scene.instantiate()
		chest.global_position = Vector3(randf_range(-20, 20), 0.5, randf_range(-20, 20))
		add_child(chest)

func _process(_delta):
	if get_tree().get_nodes_in_group("enemies").size() == 0:
		level_complete()

func level_complete():
	GameManager.current_level += 1
	if GameManager.current_level > GameManager.max_levels:
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	else:
		get_tree().reload_current_scene()
