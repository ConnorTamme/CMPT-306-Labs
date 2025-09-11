class_name Player # allows this script to be treated as type Player

extends CharacterBody2D	# indicates the type of Node this script is attached to

var wallet: Wallet

@export var speed = 400	# A speed variable that determines how many pixels the object should move per second
# @export allows this variable to be configured in the inspector, instead of needing to hardcode value in script

# this method is called each time a step in the physics simulation is calculated
# the code is being written here because the velocity and move_and_slide are part of the CharacterBody2D node
## which is a physics node
func _physics_process(_delta:float) -> void:
	# create a normalized vector composed of the four indicated input keys
	var input_direction = Input.get_vector("left", "right", "up", "down")
	# Calculate the velocity by multiplying diretion by speed
	velocity = input_direction * speed
	# Tell the CharacterBody2D node to advance one step with the physics simulation, using its velocity (set in previous line)
	# If this line is omitted, the movement will be ignored this frame
	move_and_slide()
