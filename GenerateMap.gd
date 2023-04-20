
extends Node2D


#var tilemap = null
var tileset = null
var decoration_tileset = null
var map_width = 50
var map_height = 50
var automata_iterations = 5

func _ready():
	var tilemap = $Ground
	tilemap.cell_size = Vector2(32,32)
	#add_child(tilemap)
	tileset = load("res://Assets/Scripts/Map/TileSet.tres")
	decoration_tileset = load("res://Assets/Scripts/Map/DecorationTileSet.tres")
	tilemap.tile_set = tileset
	generate_map(tilemap)
	var decoration_tilemap = $Decoration
	decoration_tilemap.cell_size = Vector2(32,32)
	tilemap.fix_invalid_tiles()
	decoration_tilemap.tile_set = decoration_tileset
	generate_tree(decoration_tilemap)
	generate_stone(decoration_tilemap)
	#var x = randi() % int(tilemap.get_used_rect().size.x - 2) + 1
	#var y = randi() % int(tilemap.get_used_rect().size.y - 2) + 1
	
#Генерируем карту
func generate_map(tilemap):
	var map_data = []
	for x in range(0, map_width):
		map_data.append([])
		for y in range(0, map_height):
			map_data[x].append(0)

	for i in range(0, automata_iterations):
		for x in range(0, map_width):
			for y in range(0, map_height):
				if randf() < 0.5:
					map_data[x][y] = 1

		for x in range(0, map_width):
			for y in range(0, map_height):
				var count = count_neighbors(map_data, x, y)
				if count > 5:
					map_data[x][y] = 1
				elif count < 5:
					map_data[x][y] = 0

	for x in range(0, map_width):
		for y in range(0, map_height):
			if map_data[x][y] == 0:
				tilemap.set_cellv(Vector2(x,y), randi() % len(tileset.get_tiles_ids()) +10)
				
#Подсчитываем кол-во соседей клетки
func count_neighbors(map_data, x, y):
	var count = 0
	for i in range(-1, 2):
		for j in range(-1, 2):
			if i == 0 and j == 0:
				continue
			if x + i < 0 or x + i >= len(map_data) or y + j < 0 or y + j >= len(map_data[0]):
				continue
			if map_data[x + i][y + j] == 1:
				count += 1
	return count

#Генерируем деревья из TileSet
func generate_tree(tilemap):
	var map_data = []
	var tree_tiles = [0,1,29,5,30, 31, 32, 33, 34]
	for x in range(0, map_width):
		map_data.append([])
		for y in range(0, map_height):
			map_data[x].append(0)
	
	for x in range(0, map_width):
		for y in range(0, map_height):
			if map_data[x][y] == 0 and randf() < 0.06:
				tilemap.set_cellv(Vector2(x,y), tree_tiles[randi() % len(tree_tiles)])

#Генерируем камни из TileSet
func generate_stone(tilemap):
	var stone_tiles = [35,36,37,38,39,40]
	var map_data = []
	for x in range(0, map_width):
		map_data.append([])
		for y in range(0, map_height):
			map_data[x].append(0)
	
	for x in range(0, map_width):
		for y in range(0, map_height):
			if map_data[x][y] == 0 and randf() < 0.01:
				var idx = stone_tiles[randi() % len(stone_tiles)]
				tilemap.set_cellv(Vector2(x,y), idx)
				
				
func _input(event):
	var tilemap = $Ground
	if event is InputEventMouseButton and event.pressed:
		var mouse_pos = get_global_mouse_position()
		var tile_pose = tilemap.world_to_map(mouse_pos)
		if tile_pose.x < map_width and tile_pose.y < map_height:
			var tile_index = tilemap.get_cellv(tile_pose)
			print(tile_index)
