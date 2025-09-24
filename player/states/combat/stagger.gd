extends "res://state_machine/state.gd"
# The stagger state end with the stagger animation from the AnimationPlayer.
# The animation only affects the Body Sprite2D's modulate property so it
# could stack with other animations if we had two AnimationPlayer nodes.

func enter() -> void:
	#owner.get_node(^"AnimationPlayer").play("stagger")
	owner.get_node(^"StaggerAnimator").play("stagger")
		#up
	#if Global.last_input_direction == Vector2(0.0,-1.0):
		#owner.get_node("/root/Main/Player/BodyPivot/AnimatedSprite2D").play("stagger_backward")
	##downs
	#elif Global.last_input_direction == Vector2(0.0,1.0):
		#owner.get_node("/root/Main/Player/BodyPivot/AnimatedSprite2D").play("stagger_forward")
	##left
	#elif Global.last_input_direction == Vector2(-1.0,0.0):
		#owner.get_node("/root/Main/Player/BodyPivot/AnimatedSprite2D").flip_h = true
		#owner.get_node("/root/Main/Player/BodyPivot/AnimatedSprite2D").play("stagger_sideways")
	##right
	#elif Global.last_input_direction == Vector2(1.0,0.0):
		#owner.get_node("/root/Main/Player/BodyPivot/AnimatedSprite2D").flip_h = false
		#owner.get_node("/root/Main/Player/BodyPivot/AnimatedSprite2D").play("stagger_sideways")


func _on_animation_finished(anim_name: String) -> void:
	assert(anim_name == "stagger")
	finished.emit("previous")
