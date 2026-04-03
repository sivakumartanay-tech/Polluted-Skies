extends Node2D
@onready var bad_guy: AnimatedSprite2D = $AnimatedSprite2D
@onready var hurtarea: Area2D = $hurtbox
@onready var hurtbox: CollisionShape2D = $hurtbox/CollisionShape2D
@onready var attack: Area2D = $attack
@onready var attack_box: CollisionShape2D = $attack/CollisionShape2D
@onready var good_guy: CharacterBody2D = $"../../Player 1"
var died = false
var badguy_health = 30
var chase_range = 50
const SPEED = 200

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Damage"):
		bad_guy.play("hurt")
		badguy_health -= 10
		print(badguy_health)
	if badguy_health <= 0:
		died = true





func _process(delta: float) -> void:
	
	var distance = global_position.distance_to(good_guy.global_position)

	
	if distance <= chase_range and distance > 30:
		
		var direction = (good_guy.global_position - global_position).normalized()
		global_position += direction * SPEED * delta
		
		if direction.x < 0:
			bad_guy.flip_h = true
		else:
			bad_guy.flip_h = false
		
	if died:
		died = true
		bad_guy.play("Death")
		await bad_guy.animation_finished
		bad_guy.queue_free()
		hurtbox.disabled = true
		attack.monitoring = false
		attack_box.disabled = true
		hurtarea.monitoring = false
		$".".queue_free()
