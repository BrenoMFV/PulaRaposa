extends Area2D

export (int) var x_start = 65	
export (int) var y_start = 65
export (int) var x_off = 40.5	
export (int) var y_off = 40.5

func _ready():
	pass
	
func pixel_to_grid(x, y):
	return Vector2(round((x - x_start)/x_off), round((y - y_start) / y_off))
	
func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		var pos = event.position
		var pos2 = pixel_to_grid(pos[0], pos[1])
		print("Clicaram em mim e minha posição é ", pos)
		print("Mas eu ocupo a casa x: ", pos2[0], " y: ", pos2[1])
		
	 # Replace with function body.
