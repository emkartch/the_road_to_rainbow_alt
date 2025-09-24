extends "on_ground.gd"

@export var max_walk_speed := 450.0
@export var max_run_speed := 700.0

func enter() -> void:
	speed = 0.0
	velocity = Vector2()

	var input_direction := get_input_direction()
	update_look_direction(input_direction)
	
	#up
	if input_direction == Vector2(0.0,-1.0):
		#owner.get_node(^"AnimatedSprite2D").play("basic_walk_backward")
		owner.get_node("/root/Main/Player/BodyPivot/AnimatedSprite2D").play("walk_backward")
		Global.last_input_direction = Vector2(0.0,-1.0)
	#down
	elif input_direction == Vector2(0.0,1.0):
		owner.get_node("/root/Main/Player/BodyPivot/AnimatedSprite2D").play("walk_forward")
		Global.last_input_direction = Vector2(0.0,1.0)
	#left
	elif input_direction == Vector2(-1.0,0.0):
		owner.get_node("/root/Main/Player/BodyPivot/AnimatedSprite2D").flip_h = true
		owner.get_node("/root/Main/Player/BodyPivot/AnimatedSprite2D").play("walk_sideways")
		Global.last_input_direction = Vector2(-1.0,0.0)
	#right
	elif input_direction == Vector2(1.0,0.0):
		owner.get_node("/root/Main/Player/BodyPivot/AnimatedSprite2D").flip_h = false
		owner.get_node("/root/Main/Player/BodyPivot/AnimatedSprite2D").play("walk_sideways")
		Global.last_input_direction = Vector2(1.0,0.0)
	

func handle_input(event: InputEvent) -> void:
	return super.handle_input(event)


func update(_delta: float) -> void:
	var input_direction := get_input_direction()
	if input_direction.is_zero_approx():
		finished.emit("idle")
	update_look_direction(input_direction)

	if Input.is_action_pressed("run"):
		speed = max_run_speed
	else:
		speed = max_walk_speed

	var collision_info := move(speed, input_direction)
	if not collision_info:
		return
	if speed == max_run_speed and collision_info.collider.is_in_group("environment"):
		return


func move(p_speed: float, direction: Vector2) -> KinematicCollision2D:
	owner.velocity = direction.normalized() * p_speed
	owner.move_and_slide()
	if owner.get_slide_collision_count() == 0:
		return null

	return owner.get_slide_collision(0)
