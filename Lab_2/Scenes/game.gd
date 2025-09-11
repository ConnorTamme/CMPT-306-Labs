extends Node

@export var wallet: Wallet = Wallet.new() #Maybe you want to set a default state of it in the editor

func _ready() -> void: #Notice that by doing this we ensure that both Pickup counter and player are using the
					   #exact same wallet without needing any globals
	$"Player".wallet = wallet
	$"PickupCounter".wallet = wallet
	$"PickupCounter".initialize()
