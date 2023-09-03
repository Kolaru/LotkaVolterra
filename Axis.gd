extends Control

@onready var sea = get_parent().get_node("Sea")

var data = PackedVector2Array()
var points = PackedVector2Array()
var xlims = Vector2(0, 10)
var ylims = Vector2(0, 10)
var time = 0.0

@export var color = Color.WHITE
@export var linewidth = 3
@export var species = "prey"

func push_data(yy):
	if yy > ylims[1]:
		ylims[1] = 1.1 * yy
		
	if time > xlims[1]:
		xlims[1] = 1.1 * time
	
	data.push_back(Vector2(time, yy))
	
func _draw():
	var xscale = size.x / xlims[1]
	var yscale = size.y / ylims[1]
	var transformation = Transform2D(0, Vector2(xscale, -yscale), 0, Vector2(0, size.y))

	points = transformation * data
	
	for i in range(len(points) - 1):
		draw_line(points[i], points[i + 1], color, linewidth)

func _process(delta):
	time += delta
	push_data(len(get_tree().get_nodes_in_group(species)))
	queue_redraw()
