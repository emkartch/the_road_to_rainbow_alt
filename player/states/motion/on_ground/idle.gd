extends "on_ground.gd"

func enter() -> void:
	#var input_direction: Vector2 = get_input_direction()
	#need to get last input direction somehow
	#owner.get_node(^"AnimatedSprite2D").play("basic_idle_forward")
	Global.direction_animation_update("idle")

	


func handle_input(event: InputEvent) -> void:
	return super.handle_input(event)


func update(_delta: float) -> void:
	var input_direction: Vector2 = get_input_direction()
	if input_direction:
		finished.emit("move")
