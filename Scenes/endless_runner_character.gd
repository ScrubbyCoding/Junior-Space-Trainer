extends CharacterBody2D


const SPEED = 300.0
@export var sprite:AnimatedSprite2D 

#dwwwwwwswfunc _init():
	#sprite.play
func _ready() -> void:
	sprite.play("walk")
func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_down", "move_up")
	if direction:
		velocity.y = -direction * SPEED
	else:
		velocity.y = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
