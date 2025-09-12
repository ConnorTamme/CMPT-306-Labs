extends Control
class_name PauseMenu

signal unpause

var main_menu: PackedScene = load("res://Scenes/title_screen.tscn")

func _on_unpause_button_up() -> void: #Signals the game to continue and removes itself from the scene tree
	unpause.emit()
	self.queue_free()


func _on_exit_button_up() -> void: #Tells the game to unfreeze time and then switches to the main_menu
	unpause.emit()
	get_tree().change_scene_to_packed(main_menu)
