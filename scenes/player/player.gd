extends CharacterBody3D

@onready var camera_mount = $camera_mount
@onready var animation_player = $visuals/mixamo_base/AnimationPlayer
@onready var visuals = $visuals

const walking_speed = 2.5
const running_speed = 5.0
var SPEED = 2.5

var max_vertical_rotation = deg_to_rad(75)
var min_vertical_rotation = deg_to_rad(-75)

var running = false
var is_locked = false

const JUMP_VELOCITY = 4.5
@export var sense_horizontal = 0.3
@export var sense_vertical = 0.3

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _input(event):
	if !State.is_player_talking:
		if event is InputEventMouseMotion:
			var vertical_rotation = -event.relative.y * sense_vertical
			var new_rotation = camera_mount.rotation.x + deg_to_rad(vertical_rotation)
			new_rotation = clamp(new_rotation, min_vertical_rotation, max_vertical_rotation)
			camera_mount.rotation.x = new_rotation
			rotate_y(deg_to_rad(-event.relative.x*sense_horizontal))
			visuals.rotate_y(deg_to_rad(event.relative.x*sense_horizontal))
	

func _physics_process(delta):
	if !State.is_player_talking:
		if !animation_player.is_playing():
			is_locked=false
		
		if Input.is_action_just_pressed("kick"):
			if animation_player.current_animation != "kick":
				animation_player.play("kick")
				is_locked=true
				animation_player.queue("knock_down")
				animation_player.queue("get_up")

		
		if Input.is_action_pressed("run"):
			running = true
			SPEED = running_speed
		else:
			running =false		
			SPEED = walking_speed	
		
		# Add the gravity.
		if not is_on_floor():
			velocity.y -= gravity * delta

		# Handle Jump.
		if Input.is_action_just_pressed('jump') and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var input_dir = Input.get_vector("left", "right", "forward", "backward")
		var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			if !is_locked:
				if running:
					if animation_player.current_animation != "running":
						animation_player.play("running")
				else:
					if animation_player.current_animation != "walking":
						animation_player.play("walking")
				visuals.look_at(position + direction)
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			if !is_locked:
				if animation_player.current_animation != "idle":
					animation_player.play("idle")
					
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
		
		if !is_locked:
			move_and_slide()
