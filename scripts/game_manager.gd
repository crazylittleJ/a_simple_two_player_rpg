extends Node

var player_count: int = 1
var ai_enabled: bool = false
var selected_classes: Array = []
var current_level: int = 1
var max_levels: int = 3

enum CharacterClass {
	WARRIOR,
	MAGE,
	HUNTER,
	PRIEST
}

func reset_game():
	current_level = 1
	selected_classes.clear()
