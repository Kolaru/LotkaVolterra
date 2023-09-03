extends Area2D

var Prey = preload("res://Prey.tscn")
var basal_rate = 0.1

func pop_prey():
	var area = get_node("CollisionShape2D")
	var rect = area.shape.get_rect()
	var min_x = area.position.x - rect.size.x/2
	var max_x = area.position.x + rect.size.x/2
	var min_y = area.position.y - rect.size.y/2
	var max_y = area.position.y + rect.size.y/2
	
	var new_prey = Prey.instantiate()
	new_prey.position.x = randf_range(min_x, max_x)
	new_prey.position.y = randf_range(min_y, max_y)
	add_child(new_prey)


func _ready():
	for i in range(30):
		pop_prey()


func _process(delta):
	if randf() < basal_rate * delta:
		pop_prey()
