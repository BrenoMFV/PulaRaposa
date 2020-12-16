extends Node

var selected_piece_pos = Vector2.ZERO

var selected_piece_color = "None"

# who's this piece anyway?
var current_player_color = "None"

# for multiple movements plays
var selection_blocked = false

var game_over = false 

# Stores current position of the pieces
var state = []



func _ready():
	pass

#func _input(event):
#	if event is InputEventMouseButton:
#		print(self.get_cellv(event.position))

