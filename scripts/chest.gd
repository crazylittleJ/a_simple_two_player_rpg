extends Area3D

var opened: bool = false

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if not opened and body.is_in_group("players"):
		opened = true
		spawn_item()
		queue_free()

func spawn_item():
	var item_scene = preload("res://scenes/item.tscn")
	var item = item_scene.instantiate()
	item.global_position = global_position
	get_parent().add_child(item)
