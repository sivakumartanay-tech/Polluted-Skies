extends Node2D
@onready var r_bad_guy: AnimatedSprite2D = $AnimatedSprite2D

@onready var animation_player: AnimationPlayer = $Cutscene/AnimationPlayer

signal player_entered

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Players"):
		emit_signal("player_entered")
		
		animation_player.play("cutscene")
		
