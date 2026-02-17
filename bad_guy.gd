extends Node2D
@onready var bad_guy: AnimatedSprite2D = $AnimatedSprite2D

var badguy_health = 30

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Damages"):
		bad_guy.play("hurt")
		badguy_health -= 10
