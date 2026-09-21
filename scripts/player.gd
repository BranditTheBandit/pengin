extends CharacterBody2D


@export var ACCELERATION := 10.
@export var MAX_SPEED := 50.
@export var JUMP_VELOCITY := -400.
@export var FRICTION := 5.


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x += clampf(direction * ACCELERATION, -MAX_SPEED, MAX_SPEED)
		$Sprite.flip_h = direction == -1
	
	# there's probably a better way to write this lol
	velocity.x += clampf(FRICTION, -absf(velocity.x), absf(velocity.x)) * -1. if velocity.x > 0. else 1.
	move_and_slide()
