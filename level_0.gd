extends Node2D
@onready var area_2d: Area2D = $Cutscene/Area2D
@onready var collision_shape_2d: CollisionShape2D = $Cutscene/Area2D/CollisionShape2D
var triggered = false
@onready var animation_player: AnimationPlayer = $Cutscene/AnimationPlayer
@onready var r_bad: AnimatedSprite2D = $AnimatedSprite2D

signal player_entered



func _on_area_2d_body_entered(body: Node2D) -> void:
	if triggered:
		return
	
	if body.is_in_group("Players"):
		triggered = true
		emit_signal("player_entered")
		animation_player.play("cutscene")
		body.position.x = 884
		body.position.y = 73
