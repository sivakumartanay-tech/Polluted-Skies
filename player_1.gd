extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0
var move = true
@onready var player: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	if move:
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta

		# Handle jump.
		if Input.is_action_just_pressed("Jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

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
		
		if not is_on_floor():
			player.play("new_animation")
		else:
			if direction != 0 and move:
				player.play("Run")
			elif  direction == 0:
				player.play("Idle")


		move_and_slide()
