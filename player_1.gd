extends CharacterBody2D

@onready var attack_monitor: Area2D = $Area2D
@onready var attackbox: CollisionShape2D = $Area2D/CollisionShape2D
var is_attacking = false
const SPEED = 200.0
const JUMP_VELOCITY = -400.0
var health = 100
var move = true
var jumping = false
var max_air_jups = 0
@onready var player: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	if move and not is_attacking:
		# Add the gravity.
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
			
		if direction < 0:
			player.flip_h = true
		else:
			player.flip_h = false
		
		if not is_on_floor() and not jumping and not is_attacking:
			player.play("Jump")
		elif jumping and not is_attacking:
			player.play("Air jump")
		else:
			if direction != 0 and move and not is_attacking:
				player.play("Run")
			elif  direction == 0 and not is_attacking:
				player.play("Idle")


		move_and_slide()

func attack():
	if is_attacking:
		return
	is_attacking = true
	attack_monitor.monitoring = true
	attackbox.disabled = false
	
	player.play("Attack")
	
	await player.animation_finished
	
	is_attacking = false
	attack_monitor.monitoring = false
	attackbox.disabled = true
