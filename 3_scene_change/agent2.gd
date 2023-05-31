extends KinematicBody



var idx = -1

var waypoints = []

var direction

export var speed = 0.05
export var waypoint_name = "waypoints"

var map: RID

var path = []


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	waypoints = get_tree().get_nodes_in_group( waypoint_name )
	map =get_world().get_navigation_map()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var target = waypoints[0].translation
	direction = translation + (target - translation)*speed
	pass
	path = NavigationServer.map_get_path(map, global_transform.origin, target, true)
	move_and_slide(direction)
	
	print(direction.length())
