extends CharacterBody2D

var speed = randf_range(100, 200)
var health = 3

@onready var player = get_node("/root/Main/Player")
@onready var animatedSprite = get_node("BodyPivot/AnimatedSprite2D")

var knockbackBool = false

#func _ready():
	#move.connect(player_velocity)

func _physics_process(delta: float) -> void:
	if knockbackBool == true:
		var kb_direction = (Global.knockback - velocity).normalized() * 10000
		velocity = kb_direction
		velocity.y -= 250
		move_and_slide()
		knockbackBool = false
	else:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * speed
		move_and_slide()
		animatedSprite.play(str(Global.level_count) + "_walk")
		
	
func mob_take_damage():
	$AnimationPlayer.play("mob_stagger")
	health -= 1
	knockbackBool = true
	if health == 0:
		queue_free()
