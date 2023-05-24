extends CanvasLayer

# var outro_scene = preload("res://scene_outro.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	print("first scene")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	print("button was pressed")
	var outro_scene = load("res://scene_outro.tscn")
	get_tree().change_scene_to(outro_scene)
	# ("Label").text = "ok, this worked"
	pass # Replace with function body.
