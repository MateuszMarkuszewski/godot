extends "res://Scripts/Stickman.gd"

onready var body = get_node("body")
var grounded = false 
onready var anim = get_node("anim")
# Jumping
var can_jump = false
var jump_time = 0
const TOP_JUMP_TIME = 0.1 # in seconds
var current_anim = "rest"
var old_anim

# Start
func _ready():
	# Set player properties
	acceleration = 1000
	top_move_speed = 200
	top_jump_speed = 400

# Apply force
func apply_force(state):
	current_anim = "rest"
		
	# Move Left
	if(Input.is_action_pressed("ui_left")):
		current_anim = "run"
		body.set_scale(Vector2(0.577636,0.582389))
		directional_force += DIRECTION.LEFT
	
	# Move Right
	if(Input.is_action_pressed("ui_right")):
		current_anim = "run"
		body.set_scale(Vector2(-0.577636,0.582389))
		directional_force += DIRECTION.RIGHT
	
	if(Input.is_action_pressed("ui_punch")):
		current_anim = "punch"
		
	if(Input.is_action_pressed("ui_punch") && Input.is_action_pressed("ui_right")):
		print("aaa")
		
	if(Input.is_action_pressed("ui_up") && jump_time < TOP_JUMP_TIME && can_jump):
		directional_force += DIRECTION.UP
		jump_time += state.get_step()
	#elif(Input.is_action_just_released("ui_up")):
	#	can_jump = false # Prevents the player from jumping more than once while in air
	
	# While on the ground
	if(grounded):
		can_jump = true
		jump_time = 0
	
	if current_anim != old_anim:
		anim.play(current_anim)
		old_anim = current_anim


func _on_ground_collision_body_enter( body ):
	# Get groups
	var groups = body.get_groups()
	
	# If we are on a solid ground
	if(groups.has("solid")):
		grounded = true



func _on_ground_collision_body_exit( body ):
	# Get groups
	var groups = body.get_groups()
	
	# If we are on a solid ground
	if(groups.has("solid")):
		grounded = false
