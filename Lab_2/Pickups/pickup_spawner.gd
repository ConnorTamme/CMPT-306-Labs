extends CollisionShape2D

@onready var timer: Timer = $"SpawnTime" #Assigns this to the timer child node. @onready means that
										 #this value is assigned when _ready is to be called which
										 #is when this node is added to the scene tree
@export var spawn_time: float
var toSpawn: PackedScene = preload("res://Pickups/pickup.tscn")
@export var pickup_container: Node

func _ready() -> void:
	timer.one_shot = false #This is false by default, but this setting is important
						   #as it determines if the timer keeps running after it has finished or not.
						   #In this case we want pickups to continue to spawn so we want it false
	
	timer.wait_time = spawn_time #Sets the timer's length
	
	timer.timeout.connect(spawn_coin) #Connects the spawn_coin function to the timer's timeout
									  #This is an example of signals in code rather than in
									  #the node section of the editor
		
	timer.start()

func spawn_coin() -> void:
	var pickup_instance: Pickup = toSpawn.instantiate() #Creates an instance of the pickup, but DOES NOT add it to the scene
	
	
	pickup_instance.position = self.position + get_random_pos_in_area() #Gives it a random position within the area
									#self.position is needed so it spawns relative to where the spawner actually is
									
	pickup_instance.initialize() #Lets it initialize itself
	
	pickup_container.add_child(pickup_instance) #Adds the pickup to the designated container

#Gets a position within the rectangle used for the spawn shape
func get_random_pos_in_area() -> Vector2:
	return Vector2(randf_range(-shape.extents.x, shape.extents.x), randf_range(-shape.extents.y, shape.extents.y))
