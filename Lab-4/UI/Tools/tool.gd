extends TextureButton
class_name Tool

#Signal to tell the hud to store this as the selected tool
signal tool_selected(tool: Tool)

var is_mouse_on: bool = false

#I add this printerr because this function should be implemented in the children.
#With how this is designed all inherited classes of this get all the functionality and connections
#Just implement this and it works
func apply_effect(_tilemap: TileMapLayer,_pos_of_cell: Vector2):
	printerr("Children of tool should inplement apply_effect(tilemap: TileMapLayer,pos_of_cell: Vector2)")

#Updates appearance of this button
func update_view(model: HUD) -> void:
	if model.selected == self:
		self.modulate = Color.YELLOW
	elif is_mouse_on:
		self.modulate = Color(0.429, 0.433, 0.384)
	else:
		self.modulate = Color(1,1,1)

#Tracks if mouse is over this button
func _on_mouse_entered() -> void:
	is_mouse_on = true

func _on_mouse_exited() -> void:
	is_mouse_on = false

#Signals hud to select this button
func _on_pressed() -> void:
	tool_selected.emit(self)
