extends Node2D

var level_grid

const BOARD_SIZE = 16
export (int) var x_start = 90
export (int) var y_start = 90
export (int) var x_off = 42	
export (int) var y_off = 42
var players_grid_size = player_grid_size(BOARD_SIZE)
var players_max_pieces = pow(players_grid_size, 2) / 4 


var players = [
	preload("res://scenes/PlayerRed.tscn"),
	preload("res://scenes/PlayerGreen.tscn"),
	preload("res://scenes/PlayerBlue.tscn"),
	preload("res://scenes/PlayerYellow.tscn")	
]

# load tiles that will be used
var tiles = {
	"light" : preload("res://scenes/TileLight.tscn"),
	"dark" : preload("res://scenes/TileDark.tscn")
}

# defines the length of the player's inner square
func player_grid_size(main_board_size):
	return int(sqrt(4 * main_board_size + 4))
	
# Convert grid coordinates to pixel values
func grid_to_pixel(x, y):
	return Vector2(x * x_off + x_start, y * y_off + y_start)

func _ready():
	level_grid = []
	for i in range(BOARD_SIZE):
		level_grid.append([])
		for j in range(BOARD_SIZE):
			# appends an odd or an even number to determine 
			# if it's going to be a light tile or a dark one
			level_grid[i].append((i + j) % 2)
			
	print(players_grid_size)
	print(players_max_pieces)

	# calls the function that will draw the tile
	draw_level()
	
func draw_level():
	for i in range(BOARD_SIZE):
		for j in range(BOARD_SIZE):
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
				
							
