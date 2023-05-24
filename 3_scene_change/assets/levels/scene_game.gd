extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	var scene = load("res://scene_outro.tscn")
	get_tree().change_scene_to(scene)
	pass # Replace with function body.


func _on_Area_body_entered(body):
	print(body)
	Global.ctr += 1
	pass # Replace with function body.
