extends CharacterBody2D

enum Direction_State {up, down, right, left}
enum Action_State {idle, moving, talking}

@export var player_direction_state = Direction_State.down;
@export var player_action_state = Action_State.idle

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var sprite : AnimatedSprite2D
@export var direction = Direction_State.down;


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	##if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	##	velocity.y = JUMP_VELOCITY
	##	
	
	if player_action_state != Action_State.talking:
		direction = Input.get_vector("move_left", "move_right", "move_up", "move_down");
		
		if direction.x:
			if direction.x > 0:
				player_direction_state = Direction_State.right
			elif direction.x < 0: 
				player_direction_state = Direction_State.left
			velocity.x = direction.x * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
		if direction.y:
			velocity.y = direction.y * SPEED
			if direction.y > 0:
				player_direction_state = Direction_State.down
			elif direction.y < 0 : 
				player_direction_state = Direction_State.up
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)
		# here we can actually have the animated sprites reflect
		# the direction
		if player_direction_state == Direction_State.up:
			if player_action_state == Action_State.idle:
				sprite.play("up_idle")
			elif player_action_state == Action_State.moving:
				sprite.play("up_walking")
		if player_direction_state == Direction_State.down:
			if player_action_state == Action_State.idle:
				sprite.play("down_idle")
			elif player_action_state == Action_State.moving:
				sprite.play("down_walking")
		if player_direction_state == Direction_State.right:
			if player_action_state == Action_State.idle:
				sprite.play("right_idle")
			elif player_action_state == Action_State.moving:
				sprite.play("right_walking")
		if player_direction_state == Direction_State.left:
			if player_action_state == Action_State.idle:
				sprite.play("left_idle")
			elif player_action_state == Action_State.moving:
				sprite.play("left_walking")


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	


	move_and_slide()
