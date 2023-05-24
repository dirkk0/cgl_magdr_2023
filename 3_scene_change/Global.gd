extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var ctr = 0

var has_key = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():

	# print("timeout", ctr)
	get_node("CanvasLayer/Label").text = str(ctr)
	pass # Replace with function body.
