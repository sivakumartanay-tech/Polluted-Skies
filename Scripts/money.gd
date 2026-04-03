extends Node2D


@export var coin_id: String


func _ready() -> void:
	coin_id = str(global_position)
	if coin_id in Global.collected_money:
		queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Players"):
		if coin_id not in Global.collected_money:
			Global.money += 1
			print(coin_id)
			Global.collected_money.append(coin_id)
			queue_free()
