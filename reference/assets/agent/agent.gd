extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var new_pos = Vector3()
var pos
var del
var dist

var vel




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	del = $Timer.connect("timeout", self, "_on_timer_timeout")
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta):
	
	pos = translation # get_global_transform().origin
	
	var l = Vector3(new_pos.x, translation.y, new_pos.z)
	look_at(l, Vector3.UP)

	dist = pos.distance_to(new_pos)
	
	if dist > 1:
		vel = (new_pos - pos).normalized()*0.05
	else:
		vel = Vector3.ZERO
	
	translation = pos + vel
	pass

func _on_timer_timeout():
	print("yay")
	new_pos = Vector3(rand_range(-5,5),rand_range(1,3),rand_range(-5,5))
	print(new_pos)
	print(translation)
	print(vel)
	# translation = new_pos
	
	# del = move_and_slide(velocity, Vector3.UP)
