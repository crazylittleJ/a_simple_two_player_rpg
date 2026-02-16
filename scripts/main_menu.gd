extends Control

func _on_one_player_pressed():
	GameManager.player_count = 1
	GameManager.ai_enabled = false
	get_tree().change_scene_to_file("res://scenes/character_select.tscn")

func _on_two_players_pressed():
	GameManager.player_count = 2
	GameManager.ai_enabled = false
	get_tree().change_scene_to_file("res://scenes/character_select.tscn")

func _on_one_player_ai_pressed():
	GameManager.player_count = 1
	GameManager.ai_enabled = true
	get_tree().change_scene_to_file("res://scenes/character_select.tscn")
