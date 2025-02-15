extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("moveLeft", "moveRight")
	
	# flip sprite depending on the direction
	if direction < 0 :
		animated_sprite.flip_h = true
	elif direction > 0 :
		animated_sprite.flip_h = false
	
	# Animation
	if is_on_floor() :
		if direction == 0:
			animated_sprite.play("Idle")
		else :
			animated_sprite.play("Move")
	else :
		animated_sprite.play("Jump")
		
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
