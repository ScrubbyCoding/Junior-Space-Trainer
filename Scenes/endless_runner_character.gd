extends CharacterBody2D


const SPEED = 150.0
@export var sprite:AnimatedSprite2D 
@export var deadScreen:Node

#dwwwwwwswfunc _init():
	#sprite.play
func _ready() -> void:
	sprite.play("walk")
func _physics_process(delta: float) -> void:
	var collision_info = move_and_collide(velocity * delta)
	if collision_info != null:
		var collider = collision_info.get_collider()
		if collider is Node2D:
			var collider2D:Node2D = collider
			var groups = collider.get_groups()
			for g in groups:
				if g == "Hazard":
					deadScreen.visible = true
			#print(collider.name)
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_down", "move_up")
	if direction:
		velocity.y = -direction * SPEED
	else:
		velocity.y = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
