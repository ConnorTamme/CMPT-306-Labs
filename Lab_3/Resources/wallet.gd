extends Resource
class_name Wallet

signal wallet_changed

@export var num_pickups: int :
	set(new_val):
		num_pickups = new_val
		wallet_changed.emit()
