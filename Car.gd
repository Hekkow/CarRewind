extends CharacterBody3D

var steering = Vector3(0, 0, 0)
var acceleration = 0.1
var speed = 0
@onready var label = $"../Label"

var movement_history = []

var rewinding = false

var started_moving = false

func _input(event):
	if event.is_action_pressed("rewind") and not rewinding:
		rewinding = true
		label.text = "rewinding"
		started_moving = false

func _physics_process(delta):
	if rewinding:
		if movement_history.is_empty():
			rewinding = false
			label.text = ""
			return
		var movement = movement_history.pop_back()
		speed = movement.speed
		transform = movement.transform
		velocity = movement.velocity
	else:
		var forward_backward = Input.get_axis("back", "forward")
		speed += forward_backward
		if forward_backward == 0:
			speed = 0
		else:
			if not started_moving:
				started_moving = true
		
		rotate_y(Input.get_axis("right", "left") * 0.1)
		
		var local_velocity = Vector3(0, 0, forward_backward * speed)
		velocity = global_transform.basis * local_velocity
		if started_moving:
			movement_history.append(Movement.new(speed, transform, velocity))
		move_and_slide()
