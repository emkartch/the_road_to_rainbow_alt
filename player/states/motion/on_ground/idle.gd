extends "on_ground.gd"

func enter() -> void:
	#var input_direction: Vector2 = get_input_direction()
	#need to get last input direction somehow
	#owner.get_node(^"AnimatedSprite2D").play("basic_idle_forward")
	Global.direction_animation_update("idle")
	#up
	#if Global.last_input_direction == Vector2(0.0,-1.0):
		#owner.get_node("/root/Main/Player/BodyPivot/AnimatedSprite2D").play("idle_backward")
	##down
	#elif Global.last_input_direction == Vector2(0.0,1.0):
		#owner.get_node("/root/Main/Player/BodyPivot/AnimatedSprite2D").play("idle_forward")
	##left
	#elif Global.last_input_direction == Vector2(-1.0,0.0):
		#owner.get_node("/root/Main/Player/BodyPivot/AnimatedSprite2D").flip_h = true
		#owner.get_node("/root/Main/Player/BodyPivot/AnimatedSprite2D").play("idle_sideways")
	##right
	#elif Global.last_input_direction == Vector2(1.0,0.0):
		#owner.get_node("/root/Main/Player/BodyPivot/AnimatedSprite2D").flip_h = false
		#owner.get_node("/root/Main/Player/BodyPivot/AnimatedSprite2D").play("idle_sideways")
	


func handle_input(event: InputEvent) -> void:
	return super.handle_input(event)


func update(_delta: float) -> void:
	var input_direction: Vector2 = get_input_direction()
	if input_direction:
		finished.emit("move")
