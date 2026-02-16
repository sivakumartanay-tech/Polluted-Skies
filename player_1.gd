extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0

var move = true
var jumping = false
var max_air_jups = 0
@onready var player: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	if move:
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta

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
		
		if not is_on_floor() and not jumping:
			player.play("Jump")
		elif jumping:
			player.play("Air jump")
		else:
			if direction != 0 and move:
				player.play("Run")
			elif  direction == 0:
				player.play("Idle")


		move_and_slide()
