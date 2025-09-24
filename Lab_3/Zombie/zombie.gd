extends CharacterBody2D
class_name Zombie

#This class is to demonstrate a basic state machine
#There are better ways of doing this but this is simple
#If you are curious on better ways check youtube

#In general a state machine is made of states and transitions. Each state has
#its own individual behaviour and then the transitions govern how you can
#move between them

#Defines the possible states
enum states {IDLE, WANDER, PURSUE}

var targetNode: Player
var cur_state: states = states.IDLE
var pursue_speed: float = 100
var wander_speed: float = 50
@onready var stateTimer: Timer = $StateTimer
var wander_direction: Vector2

func _physics_process(delta: float) -> void:
	match cur_state:
		states.IDLE:
			idle_behaviour(delta)
		states.WANDER:
			wander_behaviour(delta)
		states.PURSUE:
			pursue_behaviour(delta)
			
#Moves in a random direction and when time is up goes back to idle
func wander_behaviour(_delta: float):
	velocity = wander_direction * wander_speed
	move_and_slide()
	if stateTimer.is_stopped():
		stateTimer.start(1)
		cur_state = states.IDLE

#Chases the player
func pursue_behaviour(_delta: float):
	var direction = (targetNode.position - self.position).normalized()
	velocity = direction * pursue_speed
	move_and_slide()

#Stands still and when time is up picks a random direction and transitions  to wandering
func idle_behaviour(_delta: float):
	if stateTimer.is_stopped():
		wander_direction = Vector2(randf_range(-1,1), randf_range(-1,1))
		stateTimer.start(2)
		cur_state = states.WANDER

#If the player enters the zone switch to pursue and stop the timer
func _on_detection_zone_body_entered(body: Node2D) -> void:
	if body is Player:
		targetNode = body
		cur_state = states.PURSUE
		stateTimer.stop()

#If the player leaves we go back to idle and start the timer again
func _on_detection_zone_body_exited(body: Node2D) -> void:
	if body == targetNode:
		targetNode = null
		cur_state = states.IDLE
		stateTimer.start(1)
