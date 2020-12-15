extends Node2D

var level_grid = []

const BOARD_WIDTH = 13
const BOARD_HEIGTH = 14
const PLAYERS_GRID_HEIGTH = 8
const PLAYERS_GRID_WIDTH = 7
const CENTER_X = 8.6 
const CENTER_Y = 8.6  
const START_POS_X = 3
const START_POS_Y = 3

export (int) var x_start = 90	
export (int) var y_start = 90
export (int) var x_off = 44	
export (int) var y_off = 44

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
	
# Convert grid coordinates to pixel values
# It returns a variable that contans a list [0][1]
func grid_to_pixel(x, y):
	return Vector2(x * x_off + x_start, y * y_off + y_start)

func _ready():
	# creates grid
	for i in range(BOARD_WIDTH):
		# append a list to every list
		level_grid.append([])
		global.state.append([])
		for j in range(BOARD_HEIGTH):
			# appends an odd or an even number to determine 
			# if it's going to be a light tile or a dark one
			level_grid[i].append((i + j) % 2)
			global.state[i].append('-')
			
	draw_level()
	set_players()
	
func draw_level():
	for i in range(BOARD_WIDTH):
		for j in range(BOARD_HEIGTH):
			if level_grid[i][j] == 0:
				var tile = tiles.dark.instance()
				add_child(tile)
				var pos = grid_to_pixel(i, j)
				tile.position = Vector2(pos[0], pos[1])
			else:
				var tile = tiles.light.instance()
				add_child(tile)
				var pos = grid_to_pixel(i, j)
				tile.position = Vector2(pos[0], pos[1])

func set_players():
	# (3,3)____(0,3)	
	# |			|		
	# |	        |		
	# |			|		
	# (3,10)___(9,10)	
	for i in range(PLAYERS_GRID_WIDTH):
		var col = START_POS_X + i
		for j in range(PLAYERS_GRID_HEIGTH):
			var row = START_POS_Y + j
			# defines which piece from pieces[] 
			# is instanciated
			var current_player = (i + j) % 4 
			var piece = pieces[current_player].scn.instance()
			var pos = grid_to_pixel(col, row)
			piece.position = Vector2(pos[0], pos[1])
			piece.color = pieces[current_player].color
			print(piece.position, piece.color)
			global.state[col][row] = piece.color
			add_child(piece)
			# ideia inicial:
			# criar um dicionário de listas 
#			state.color = {piece : Vector2(col, row)}

			piece.get_node("Sprite").set_offset(Vector2(CENTER_X, CENTER_Y))
		
func def():
	pass
