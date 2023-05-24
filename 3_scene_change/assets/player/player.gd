extends KinematicBody

var del

export var speed = 10
export var acceleration = 5
export var gravity = 0.98
export var jump_power = 35
export var mouse_sensitivity = 0.3

var paused = false

export var scene : NodePath

var velocity:Vector3

onready var cam = get_node("Head/Camera")  # $Head/Camera

var mode = 0

var bot_state

func _ready():
	pass
	print(scene)
	
	scene = "Head"
	var real_scene = get_node(scene)
	print(real_scene)


	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	# global.gplayer = self
	add_to_group("player")

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if paused == false:
			get_node("%Button").visible = true  # absolute reference
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			paused = true
		else:
			get_node("%Button").visible = false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			paused = false
			
#		if Global.freeze:
#			get_tree().quit()
#		Global.freeze = true # not Global.freeze
		# if Input.get_mouse_mode()
		
	# if Global.freeze: return

	var direction:Vector3 = Vector3.ZERO
	var aim = cam.get_camera_transform().basis
	if Input.is_action_pressed("ui_w"):
		direction -= aim.z
	if Input.is_action_pressed("ui_s"):
		direction += aim.z
	if Input.is_action_pressed("ui_a"):
		direction -= aim.x
	if Input.is_action_pressed("ui_d"):
		direction += aim.x
	if Input.is_action_pressed("ui_f"):
		OS.window_fullscreen = !OS.window_fullscreen
	if Input.is_action_just_pressed("ui_e"):
		print("e")
		var r = $Head/Camera/RayCast
		var b = r.get_collider()
		print(r.get_collision_point(), r.is_colliding())
		if b:
			var p = b.get_parent().get_parent()
			var o = b.get_owner()
#			print("body ", b)
#			print("parent ", p)
#			print("owner ", o)

			if o and o.has_method("activate"):
				o.activate()
			if b.has_method("activate"):
				b.activate()
			if p.has_method("activate"):
				p.activate()

	direction = direction.normalized()
	# g4 velocity = velocity.lerp(direction * speed, acceleration * delta)
	velocity = velocity.linear_interpolate(direction * speed, acceleration * delta)
	velocity.y -= gravity

	if Input.is_action_just_pressed("ui_select") and is_on_floor():
		velocity.y += jump_power

	if Input.is_action_just_pressed("ui_page_down"):
		mode = fmod(mode + 1, 3)
		print(str(mode))
		if mode == 0:
			gravity = 0.9
			$CollisionShape.disabled = true
		if mode == 1:
			gravity = 0
			$CollisionShape.disabled = false
		if mode == 2:
			gravity = 0
			$CollisionShape.disabled = true

	# g4 move_and_slide()
	del = move_and_slide(velocity, Vector3.UP)


func _input(event):

#	if Global.freeze:
#		if event is InputEventKey and event.pressed:
#			if event.scancode != KEY_ESCAPE:
#				Global.freeze = false
#				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
#
#
#	if Global.freeze: return


	
	if event is InputEventMouseMotion:
		if paused == false:
			# g4 self.rotate_y(deg_to_rad(-event.relative.x) * mouse_sensitivity)
			self.rotate_y(deg2rad(-event.relative.x) * mouse_sensitivity)

			#  g4 cam.rotate_x(deg_to_rad(-event.relative.y) *mouse_sensitivity)
			cam.rotate_x(deg2rad(-event.relative.y) *mouse_sensitivity)
			cam.rotation.x = clamp(cam.rotation.x, -PI*0.3, PI*0.3)
