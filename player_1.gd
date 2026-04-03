extends CharacterBody2D
@onready var attack_monitor: Area2D = $Area2D
@onready var hitbox: CollisionShape2D = $CollisionShape2D
@onready var attackbox: CollisionShape2D = $Area2D/CollisionShape2D
var is_attacking = false
const SPEED = 200.0
const JUMP_VELOCITY = -400.0
var health = 100
var move = true
var jumping = false
var is_running = false
var max_air_jups = 0
var dead = false
var max_lives = 3
var hit = false
@onready var player: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:

	if not move:
		velocity = Vector2.ZERO
		return

	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("Attack"):
		attack()
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		max_air_jups = 1
	elif Input.is_action_just_pressed("Jump") and max_air_jups > 0:
		max_air_jups -= 1
		jumping = true
		velocity.y = JUMP_VELOCITY
	if is_on_floor():
		jumping = false

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if velocity.x < 0:
		player.flip_h = true
		hitbox.position.x = 15
		attackbox.position.x = -14
	elif velocity.x > 0:
		attackbox.position.x = 14
		hitbox.position.x = -4
		player.flip_h = false

		player.flip_h = false
	if not dead and not is_attacking:
		if hit:
			player.play("Hurt")
			hit = false
		elif not is_on_floor() and not jumping and not hit:
			player.play("Jump")
		elif jumping and not hit and not is_attacking:
			player.play("Air jump")
		elif direction != 0 and move and not hit:
				is_running = true
				player.play("Run")
		elif  direction == 0 or not move and not hit:
			is_running = false
			player.play("Idle")
	move_and_slide()

func attack():
	if is_attacking:
		return

	is_attacking = true
	attack_monitor.monitoring = true
	attackbox.disabled = false
	
	player.play("Run attack")
	
	await get_tree().create_timer(0.5).timeout
	
	for body in attack_monitor.get_overlapping_bodies():
		if body.is_in_group("enemies"):
			body.badguy_health -= 10
			body.hit = true
			print("enemy health =" + str(body.badguy_health))
	
	is_attacking = false
	attack_monitor.monitoring = false
	attackbox.disabled = true
	
func _process(delta: float) -> void:
	if health <= 0:
		dying()

func _on_level_0_player_entered() -> void:
	move = false # Replace with function body.
	player.play("Idle")
	await get_tree().create_timer(2.0).timeout
	move = true
	
	
func dying():
	dead = true
	player.play("Death")
	await player.animation_finished
	hitbox.disabled = true
	move = false
	max_lives -= 1
	get_tree().reload_current_scene()
