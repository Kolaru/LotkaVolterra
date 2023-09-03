extends Node2D

@export var label: String
@export var duration = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = label
	var tween = create_tween()
	tween.tween_property($Label, "modulate", Color.TRANSPARENT, duration)
	tween.parallel().tween_property($Label, "position", Vector2(0, -50), duration)
	tween.tween_callback(queue_free)
