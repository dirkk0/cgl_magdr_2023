extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var idx = -1

var waypoints = []

var direction

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	waypoints = get_tree().get_nodes_in_group("waypoints")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	var new_pos = waypoints[idx].translation
	var pos = translation
	
	direction = new_pos - pos
	translation = pos + direction * 0.01
	


func _on_Timer_timeout():
	print("works")
	
	idx = fmod(idx +1, waypoints.size() )
	
	var pos = waypoints[idx].translation

	
	# var x = rand_range(0,10)
	# var z = rand_range(0, 10)
	# translation = pos
	pass # Replace with function body.
