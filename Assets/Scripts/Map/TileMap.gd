extends TileMap

var building_tiles = [1, 2, 3] # тайлы зданий
var main_building_tile = 10 # тайл главного здания
var main_building_distance = 5 # расстояние до главного здания

func _ready():
	print(build_building(2, 2))
	print(get_main_building_pos())

func build_building(x: int, y: int) -> bool:
	if not can_build_building(x, y):
		return false

	set_cell(x, y, building_tiles[randi() % building_tiles.size()])
	return true

func can_build_building(x: int, y: int) -> bool:
	if get_cellv(Vector2(x, y)) != -1:
		return false

	var main_building_pos = get_main_building_pos()
	if main_building_pos.distance_to(Vector2(x, y)) > main_building_distance:
		return false

	var bounds = Rect2(Vector2(x - 1, y - 1), Vector2(3, 3))
	for cell in get_used_cells():
		if bounds.has_point(cell):
			return false

	return true

func get_main_building_pos() -> Vector2:
	for cell in get_used_cells():
		if get_cellv(cell) == main_building_tile:
			return cell
	return Vector2(-1, -1)
