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
	var scene = load("res://scene_main.tscn")
	get_tree().change_scene_to(scene)
	# ("Label").text = "ok, this worked"
	pass # Replace with function body.


