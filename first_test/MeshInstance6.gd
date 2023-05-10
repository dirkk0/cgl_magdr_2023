extends MeshInstance


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var d = 0
var speed = 0.2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	# self.translation = self.translation - Vector3(speed*delta, 0, 0)
	self.translation.x -= speed*delta
#	
#	d += delta
#   self.translation = Vector3(d * speed, 1, 0)
