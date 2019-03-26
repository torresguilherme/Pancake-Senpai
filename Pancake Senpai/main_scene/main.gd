extends Node

const N = 1
const E = 2
const S = 4
const W = 8

var map = {
    Vector2(): null
}

func has_less_than_n_neighbours(x, y, max_x, max_y):
	var count = 0
	if x < max_x - 1 and map[Vector2(x + 1, y)]:
		count += 1
	if x > 0 and map[Vector2(x - 1, y)]:
		count += 1
	if y > 0 and map[Vector2(x, y - 1)]:
		count += 1
	if y < max_y - 1 and map[Vector2(x, y + 1)]:
		count += 1
	print(count)
	return count < 2
	

func generate_map(x, y, num_rooms):
	for i in range(x):
		for j in range(y):
			map[Vector2(i, j)] = 0
	var rand_cell = Vector2(int(rand_range(x * .25, x * .75)), int(rand_range(y * .25, y * .75)))
	map[rand_cell] = int(rand_range(0, 14))
	
	for i in range(num_rooms - 1):
		var candidates = []
		for j in range(x):
			for k in range(y):
				if map[Vector2(j, k)]: # to do: avoid nesting
					if j > 0 and map[Vector2(j, k)] & N and !map[Vector2(j-1, k)]:
						if(has_less_than_n_neighbours(j-1, k, x, y)):
							candidates.append(Vector2(j-1, k))
					if k < y and map[Vector2(j, k)] & E and !map[Vector2(j, k+1)]:
						if(has_less_than_n_neighbours(j, k+1, x, y)):
							candidates.append(Vector2(j, k+1))
					if j < x and map[Vector2(j, k)] & S and !map[Vector2(j+1, k)]:
						if(has_less_than_n_neighbours(j+1, k, x, y)):
							candidates.append(Vector2(j+1, k))
					if k > 0 and map[Vector2(j, k)] & W and !map[Vector2(j, k-1)]:
						if(has_less_than_n_neighbours(j, k-1, x, y)):
							candidates.append(Vector2(j, k-1))
		var chosen = candidates[randi() % candidates.size()]
		map[chosen] = 15
	
	for i in range(x):
		var grid = ""
		for j in range(y):
			grid += str(map[Vector2(i, j)]) + " "
		print(grid)

func _ready():
	randomize()
	var x = 8; var y = 8; var num_rooms = 10
	generate_map(x, y, num_rooms)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()