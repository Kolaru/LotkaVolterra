extends Fish

var TimedLabel = preload("res://TimedLabel.tscn")

var death_rate = 0.15
var birth_rate = 0.2

var turn_rate = 1
	

func turn():
	rotation = randf_range(0, 2*PI)
	velocity.x = speed * cos(rotation)
	velocity.y = speed * sin(rotation)
	
func eat(prey):
	if prey.species == "prey":
		var miam = TimedLabel.instantiate()
		miam.position = $TextStart.position
		add_child(miam)
		prey.die()
		
		if randf() < birth_rate:
			reproduce()

func _process(delta):
	if randf() < turn_rate * delta:
		turn()
	
	if randf() < death_rate * delta:
		die()
