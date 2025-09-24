class_name Pickup # allows this script to be treated as the type Pickup

extends Area2D # indicates the type of Node this script is attached to

@export var magnetize_speed: float = 50
var magnet_target: Player

func initialize() -> void: #Basic initialize() function. No important function other than to show making setup explicit
	print("Spawned Coin!")

func _physics_process(delta: float) -> void:
	if magnet_target != null: #If there is a magnetism target (the player) pull the pickup towards them
		self.position = self.position.move_toward(magnet_target.position, delta * magnetize_speed)

# callback method from the corresponding signal sent by the Area2D
func _on_body_entered(body): 
	# checking if the thing colliding with the Area2D is the Player (using the Player scripts class_name)
	if body is Player:	
		body.wallet.num_pickups += 1
		# removes myself (i.e., the pickup) from the scene tree and frees up the memory
		queue_free()	


func _on_magnetism_area_body_entered(body: Node2D) -> void: #Called when the player enters the magnetism area
	if body is Player:
		magnet_target = body


func _on_magnetism_area_body_exited(body: Node2D) -> void: #Called when the player exits the magnetism area
	if body == magnet_target:
		magnet_target = null
