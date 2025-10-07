class_name Player # allows this script to be treated as type Player

extends CharacterBody2D	# indicates the type of Node this script is attached to

var wallet: Wallet

@export var speed = 400	# A speed variable that determines how many pixels the object should move per second
# @export allows this variable to be configured in the inspector, instead of needing to hardcode value in script
@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D

# this method is called each time a step in the physics simulation is calculated
# the code is being written here because the velocity and move_and_slide are part of the CharacterBody2D node
## which is a physics node
func _physics_process(_delta:float) -> void:
	# create a normalized vector composed of the four indicated input keys
	var input_direction = Input.get_vector("left", "right", "up", "down")
	# Calculate the velocity by multiplying diretion by speed
	velocity = input_direction * speed
	
	#This controls which animation should play
	if input_direction.length() > 0:
		if abs(input_direction.x) > abs(input_direction.y):
			animatedSprite.animation = "walk_H"
		else:
			animatedSprite.animation = "walk_V"
	else:
		animatedSprite.animation = "default"
	
	#This handles any sprite flipping
	if input_direction.y < 0:
		animatedSprite.flip_v = false
	elif  input_direction.y > 0:
		animatedSprite.flip_v = true
	else:
		animatedSprite.flip_v = false
	
	if input_direction.x < 0:
		animatedSprite.flip_h = true
	elif input_direction.x > 0:
		animatedSprite.flip_h = false
		
	#Special input handling
	#Important note is that this sort of differential handling is probably better
	#off inside of a state machine with a "crouch" and "roll" state
	if Input.is_action_pressed("crouch"):
		animatedSprite.animation = "crouch"
		animatedSprite.flip_v = false
		velocity = input_direction * speed * 0.5
	
	if Input.is_action_pressed("roll"):
		animatedSprite.animation = "roll"
		animatedSprite.flip_v = false
		velocity = input_direction * speed * 1.5
	
	#Ensures the animation plays
	animatedSprite.play()
	# Tell the CharacterBody2D node to advance one step with the physics simulation, using its velocity (set in previous line)
	# If this line is omitted, the movement will be ignored this frame
	move_and_slide()
