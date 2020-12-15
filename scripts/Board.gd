extends Node2D

var level_grid = []
var state = {}

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

var players = {
	0 : preload("res://scenes/Players/PlayerRed.tscn"),
	1 : preload("res://scenes/Players/PlayerGreen.tscn"),
	2 : preload("res://scenes/Players/PlayerBlue.tscn"),
	3 : preload("res://scenes/Players/PlayerYellow.tscn")	
}

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
		for j in range(BOARD_HEIGTH):
			# appends an odd or an even number to determine 
			# if it's going to be a light tile or a dark one
			level_grid[i].append((i + j) % 2)
			
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
			# defines which piece from players[] 
			# is instanciated
			var color = (i + j) % 4 
			var player = players[color].instance()
			add_child(player)
			var pos = grid_to_pixel(col, row)
			player.position = Vector2(pos[0], pos[1])
			# ideia inicial:
			# criar um dicionário de listas 
#			state.color = {piece : Vector2(col, row)}

			player.get_node("Sprite").set_offset(Vector2(CENTER_X, CENTER_Y))
	for piece in state:
		print(state[piece])
