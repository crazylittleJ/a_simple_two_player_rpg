extends Area3D

enum ItemType {
	HP_SMALL,
	HP_MEDIUM,
	MP_SMALL,
	MP_MEDIUM
}

@export var item_type: int = ItemType.HP_SMALL

func _ready():
	body_entered.connect(_on_body_entered)
	item_type = randi() % 4

func _on_body_entered(body):
	if body.is_in_group("players"):
		apply_effect(body)
		queue_free()

func apply_effect(player):
	match item_type:
		ItemType.HP_SMALL:
			player.heal(20)
		ItemType.HP_MEDIUM:
			player.heal(50)
		ItemType.MP_SMALL:
			player.restore_mp(20)
		ItemType.MP_MEDIUM:
			player.restore_mp(50)
