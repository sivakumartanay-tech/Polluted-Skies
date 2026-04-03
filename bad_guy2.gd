extends CharacterBody2D

var can_fall = false
var moving = false
@onready var bad_guy: AnimatedSprite2D = $AnimatedSprite2D
@onready var hurtarea: Area2D = $hurtbox
@onready var hurtbox: CollisionShape2D = $hurtbox/CollisionShape2D
@onready var attack: Area2D = $attack
@onready var attack_box: CollisionShape2D = $attack/CollisionShape2D
@onready var good_guy: CharacterBody2D = $"../../Player 1"
@onready var bod: CollisionShape2D = $CollisionShape2D
var died = false
var is_attacking = false
var badguy_health = 30
var chase_range = 150
const SPEED = 100
var dir = 1
var fell = false
var hit = false




func _process(delta: float) -> void:

	if hit:
		bad_guy.play("hurt")
		hit = false
	elif moving and not is_attacking and not hit:
		bad_guy.play("Run")
	elif not is_attacking and not hit:
		bad_guy.play("Idle")

	if badguy_health <= 0:
		died = true
	
	
	if died:
		if fell:
			return
		died = true
		Global.money += 10
		bad_guy.play("Death")
		hurtbox.disabled = true
		attack.monitoring = false
		attack_box.disabled = true
		hurtarea.monitoring = false
		queue_free()
	
	if bad_guy.global_position.y >= 277:
		print("ded")
		Global.money += 10
		fell = true
		died = true
		hurtbox.disabled = true
		attack.monitoring = false
		attack_box.disabled = true
		hurtarea.monitoring = false
		



const JUMP_VELOCITY = -400.0
@onready var view: RayCast2D = $RayCast2D




func _physics_process(delta: float) -> void:
	
	if not view.is_colliding():
		can_fall = true
	else:
		can_fall = false
		velocity.x = 0
	
	
	var distance = global_position.distance_to(good_guy.global_position)
	
	
	if distance <= chase_range and distance >= 30 and not is_attacking and not can_fall:
		moving = true
		var direction = (good_guy.global_position - global_position).normalized()
		velocity.x = direction.x * SPEED
		flip()

	elif distance <= 30 and not is_attacking:
		enemy_attack()
	else:
		moving = false
		velocity.x = move_toward(velocity.x,0,100)
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta


	move_and_slide()
	
func enemy_attack():
	
	is_attacking = true
	
	moving = false
	velocity.x = 0
	
	
	
	bad_guy.play("Attack")
	
	
	
	await get_tree().create_timer(1.3).timeout
	
	for body in attack.get_overlapping_bodies():
		if body.is_in_group("Players"):
			good_guy.health -= 10
			good_guy.hit = true
			break
	
	await get_tree().create_timer(0.5).timeout
	
	
	is_attacking = false

func flip():
	var direction = (good_guy.global_position - global_position).normalized()

	if direction.x < 0:
		bad_guy.flip_h = true
		attack_box.position.x = -20.5
		hurtbox.position.x = 12
		bod.position.x = 12
			
	else:
		attack_box.position.x = 20.5
		hurtbox.position.x = -12
		bod.position.x = -12
		bad_guy.flip_h = false
