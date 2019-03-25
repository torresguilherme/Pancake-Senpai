extends Node

const N = 1
const E = 2
const S = 4
const W = 8

var map = {
    Vector2(): null
}


func generate_map(x, y):


	for i in range(x):
		for j in range(y):
			map[Vector2(i, j)] = 0

	var rand_cell = Vector2(int(rand_range(x * .25, x * .75)), int(rand_range(y * .25, y * .75)))
	map[rand_cell] = int(rand_range(0, 14))


	



	for i in range(x):
		var grid = ""
		for j in range(y):
			grid += str(map[Vector2(i, j)]) + " "
		print(grid)



func _ready():
	randomize()

	var x = 8; var y = 8

	generate_map(x, y)









func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()