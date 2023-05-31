extends KinematicBody

onready var navigation = $"../Navigation"
var target # = $"../Position3D"

var speed = 10.0

var path = []
var path_index = 0
var pois = []
var poi_index = 0

var map : RID

func _ready():
	pois = get_tree().get_nodes_in_group("pois")
	# use call deferred to make sure the entire SceneTree Nodes are setup
	# else if yield on 'physics_frame' in a _ready() sceneload might get stuck
	call_deferred("setup")

func setup():
	map = get_world().get_navigation_map()
	yield(get_tree(),"physics_frame")

func _physics_process(delta):
	if path_index < path.size():
		var direction = path[path_index] - global_transform.origin
		if direction.length() < 1:
			path_index += 1
		else:
			move_and_slide(direction.normalized()*speed)
	else:
		poi_index = fmod(poi_index + 1, pois.size())
		target = pois[poi_index]
		path_index = 0
		path = NavigationServer.map_get_path(map, global_transform.origin, target.translation, true)
		print("im there", poi_index)

