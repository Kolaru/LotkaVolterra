extends Area2D
class_name Fish

var sea
var min_x
var max_x
var min_y
var max_y

@export var max_speed = 300.0
@export var min_speed = 100.0
var speed = 200.0
var velocity = Vector2(0, 0)

@export var species = "unkown"
@export var min_fish = 1
@export var max_fish = 100

signal collide_with_fish(fish)
signal born(fish)
signal died(fish)


func get_number():
	return len(get_tree().get_nodes_in_group(species))


func die():
	if get_number() > min_fish:
		queue_free()
		died.emit(self)


func reproduce():
	if get_number() < max_fish:
		var new_fish = duplicate()
		new_fish.position = position
		add_sibling(new_fish)


func _ready():
	sea = get_parent()
	add_to_group(species)
	born.emit(self)

	rotation = randf_range(0, 2*PI)
	speed = randf_range(min_speed, max_speed)
	velocity.x = speed * cos(rotation)
	velocity.y = speed * sin(rotation)
	
	var area = sea.get_node("CollisionShape2D")
	var rect = area.shape.get_rect()
	min_x = area.position.x - rect.size.x/2
	max_x = area.position.x + rect.size.x/2
	min_y = area.position.y - rect.size.y/2
	max_y = area.position.y + rect.size.y/2


func _physics_process(delta):
	rotation = atan2(velocity.y, velocity.x)
	position += delta * velocity
	
	if monitoring:
		for area in get_overlapping_areas():
			if area is Fish:
				collide_with_fish.emit(area)

	if position.x > max_x:
		position.x = min_x
	elif position.x < min_x:
		position.x = max_x
	
	if position.y > max_y:
		position.y = min_y
	elif position.y < min_y:
		position.y = max_y
