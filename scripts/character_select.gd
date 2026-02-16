extends Control

func _on_class_selected(class_type: int):
	GameManager.selected_classes.append(class_type)
	
	if GameManager.selected_classes.size() < GameManager.player_count + (1 if GameManager.ai_enabled else 0):
		$VBoxContainer/Title.text = "玩家 %d 選擇職業" % (GameManager.selected_classes.size() + 1)
	else:
		get_tree().change_scene_to_file("res://scenes/game_level.tscn")
