extends CanvasLayer
class_name HUD

var selected: Tool
@export var tilemap: TileMapLayer

#Connects to all of the tools to catch selection signals
func _ready() -> void:
	for tool: Tool in $ToolContainer.get_children():
		tool.tool_selected.connect(select_new)

#Updates view of each tool
func _process(_delta: float) -> void:
	for tool: Tool in $ToolContainer.get_children():
		tool.update_view(self)

#Does input handling
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if selected != null:
			selected.apply_effect(tilemap, tilemap.local_to_map(tilemap.to_local(event.global_position)))
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		selected = null

#Function to select new tool. This could have probably been a lambda function
#inside the ready loop to declutter the script but this is fine too
func select_new(tool: Tool) -> void:
	selected = tool
