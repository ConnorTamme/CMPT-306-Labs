extends Tool

#Changes tile to dirt
func apply_effect(tilemap: TileMapLayer,pos_of_cell: Vector2):
	tilemap.set_cell(pos_of_cell, 0, Vector2(1,0))
