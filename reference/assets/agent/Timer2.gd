extends Timer

var del

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var pos

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	connect("timeout", self, "_on_timer_timeout")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	pos = get_node("..").translation
	# print(pos)


func _on_timer_timeout():
	print("yay2")
#	print(new_pos)
#	print(get_parent().translation)
