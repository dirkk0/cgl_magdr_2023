extends KinematicBody

var del

export var speed = 10
export var acceleration = 5
export var gravity = 0 # 0.98
export var jump_power = 35
export var mouse_sensitivity = 0.3

var velocity:Vector3

onready var cam = $Head/Camera

var mode = 0

var bot_state

func _ready():
	pass
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	# global.gplayer = self
	add_to_group("player")

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		if Global.freeze:
			get_tree().quit()
		Global.freeze = true # not Global.freeze
		# if Input.get_mouse_mode()
		
	if Global.freeze: return

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

	if Global.freeze:
		if event is InputEventKey and event.pressed:
			if event.scancode != KEY_ESCAPE:
				Global.freeze = false
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


	if Global.freeze: return


	
	if event is InputEventMouseMotion:
		# g4 self.rotate_y(deg_to_rad(-event.relative.x) * mouse_sensitivity)
		self.rotate_y(deg2rad(-event.relative.x) * mouse_sensitivity)

		#  g4 cam.rotate_x(deg_to_rad(-event.relative.y) *mouse_sensitivity)
		cam.rotate_x(deg2rad(-event.relative.y) *mouse_sensitivity)
		cam.rotation.x = clamp(cam.rotation.x, -PI*0.3, PI*0.3)
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			pass
			# fire_gun()

export var health = 1000
func damage(amnt):
	print(self.name + " ouch " + str(health))
	# global.doHurt()
	health -= amnt
	if health <= 0:
#		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
#		var temp = ""
#		temp += "blue " + str(get_tree().get_nodes_in_group("blue").size())
#		temp += "\nred " + str(get_tree().get_nodes_in_group("red").size())
#		OS.alert(temp, 'Message Title')
#		get_tree().quit()
		print("DEAD!!!")
#		self.rotate(Vector3.FORWARD, 90)
#
# var bullet_scn = preload("res://assets/entities/bullet/bullet.tscn")



#	new_bullet.speed = 15
#	new_bullet.damage = 50


#const SPEED = 5.0
#const JUMP_VELOCITY = 4.5
#
## Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
#
#
#func _physics_process(delta):
#	# Add the gravity.
#	if not is_on_floor():
#		velocity.y -= gravity * delta
#
#	# Handle Jump.
#	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#		velocity.y = JUMP_VELOCITY
#
#	# Get the input direction and handle the movement/deceleration.
#	# As good practice, you should replace UI actions with custom gameplay actions.
#	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
#	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
#	if direction:
#		velocity.x = direction.x * SPEED
#		velocity.z = direction.z * SPEED
#	else:
#		velocity.x = move_toward(velocity.x, 0, SPEED)
#		velocity.z = move_toward(velocity.z, 0, SPEED)
#
#	move_and_slide()
