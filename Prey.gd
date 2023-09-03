extends Fish

var flapping_speed = 420.0
var flapping_angle = 40.0
var flapping_direction = 1
@onready var neutral_tail_angle = $Tail.rotation

var birth_rate = 0.15
	
func _process(delta):
	flap(delta)
	if randf() < birth_rate * delta:
		reproduce()

func flap(delta):
	$Tail.rotation += flapping_direction  * deg_to_rad(flapping_speed * delta)
	if abs($Tail.rotation - neutral_tail_angle) >= deg_to_rad(flapping_angle):
		flapping_direction *= -1
