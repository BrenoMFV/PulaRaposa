extends TileMap

var level_grid = []

# measures of the whole board
const BOARD = Vector2(15,16)

# measures of the player inital grid
const PLAYERS_GRID = Vector2(7,8)

# values to center the piece's offset 
var CENTER_X = 8.6
var CENTER_Y = 8.6

# start position to the player's grid like this:
	# (4,4)____(4,11)	
	# |			|		
	# |	        |		
	# |			|		
	# (11,4)___(10,11)	
const START_POS_X = sqrt(BOARD.y)
const START_POS_Y = sqrt(BOARD.y)

export (int) var x_start = 65	
export (int) var y_start = 65
export (int) var x_off = 40.5	
export (int) var y_off = 40.5

var pieces = {
	0 : {
		"color": "red",
		"scn" : preload("res://scenes/Pieces/PieceRed.tscn"),
	}, 
	1 : {
		"color": "green",
		"scn" : preload("res://scenes/Pieces/PieceGreen.tscn"),
	}, 
	2 : {
		"color": "blue",
		"scn" : preload("res://scenes/Pieces/PieceBlue.tscn"),
	}, 
	3 : {
		"color": "yellow",
		"scn" : preload("res://scenes/Pieces/PieceYellow.tscn"),
	}}

# load tiles that will be used
var tiles = {
	"light" : preload("res://scenes/TileLight.tscn"),
	"dark" : preload("res://scenes/TileDark.tscn")
}

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT \
		and event.pressed:
			var pos = event.position
			attempt_piece_selection(pos)
				
func _ready():
	# creates grid
	for i in range(BOARD.x):
		# append a list to every list
		level_grid.append([])
		global.state.append([])
		for j in range(BOARD.y):
			# appends an odd or an even number to determine 
			# if it's going to be a light tile or a dark one
			level_grid[i].append((i + j) % 2)
			global.state[i].append('-')
			
	draw_level()
	set_players()
	
func draw_level():
	for x in range(BOARD.x):
		for y in range(BOARD.y):
			# Para representar as casas finais, escolhi colocar todos os tiles escuros 
			if x == 0 or y == 0 or \
			x == BOARD.x - 1 or y == BOARD.y - 1:
				positioning_tile(tiles['dark'], x, y)
			elif level_grid[x][y] == 0:
				positioning_tile(tiles['dark'], x, y)
			else:
				positioning_tile(tiles['light'], x, y)
				
# Convert grid coordinates to pixel values
# It returns a variable that contans a list [0][1]
func grid_to_pixel(x, y):
	return Vector2(x * x_off + x_start, y * y_off + y_start)
	
func pixel_to_grid(x, y):
	return Vector2(x / x_off - x_start, y / y_off - y_start)

func positioning_tile(tile_class, x, y) -> void:
	var tile = tile_class.instance()
	tile.position = grid_to_pixel(x, y)
	add_child(tile)
#	tile.set_cell(i, j, 1)
#	tile.position = map_to_world(pos)

func set_players():
	for i in range(PLAYERS_GRID.x):
		var col = START_POS_X + i
		for j in range(PLAYERS_GRID.y):
			var row = START_POS_Y + j
			var pos = grid_to_pixel(col, row)
			var current_player = (i + j) % 4 
			var piece = pieces[current_player].scn.instance()
			
			piece.position = Vector2(pos[0], pos[1])
			piece.color = pieces[current_player].color
			
			global.state[col][row] = piece.color
			
			add_child(piece)
			
			piece.get_node("Sprite").set_offset(Vector2(CENTER_X, CENTER_Y))
		
func attempt_piece_selection(pos):
	pass
