extends Node2D

var freeze : bool = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	if freeze:
		Engine.time_scale = 0.05
	else:
		Engine.time_scale = 1.0

