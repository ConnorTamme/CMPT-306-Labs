extends Node

var wallet: Wallet = Wallet.new() 
@export var pause_menu: PackedScene
var paused: bool = false

func _ready() -> void: #Notice that by doing this we ensure that both Pickup counter and player are using the
					   #exact same wallet without needing any globals
	$"Player".wallet = wallet
	$"PickupCounter".wallet = wallet
	$"PickupCounter".initialize()

func _input(event: InputEvent) -> void:
	if event.is_action_released("pause") and !paused:
		Engine.time_scale = 0.0 #This pauses time. Essentially this multiplies delta by 0 for everything every frame. By default it is 1. 
		var pause_menu_inst = pause_menu.instantiate() #Makes an instance of the pause menu
		pause_menu_inst.unpause.connect(unpause)  #Connects to the pause menus unpause signal so the pause menu can let us know when it dies
		paused = true #Tracks that the game is paused so we can't repause the game
		self.add_child(pause_menu_inst) #Adds the pause menu to the scene tree
		
func unpause() -> void:
	Engine.time_scale = 1.0 #Starts time again
	paused = false #Tracks the game is unpaused
