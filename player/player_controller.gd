extends CharacterBody2D
# The Player is a CharacterBody2D, in other words a physics-driven object.
# It can move, collide with the world, etc...
# The player has a state machine, but the body and the state machine are separate.

signal direction_changed(new_direction: Vector2)
signal health_depleted

var screen_size # Size of the game window.
var health = 100.0
@onready var main = get_node("/root/Main")
@onready var state_machine = get_node("/root/Main/Player/StateMachine")
@onready var animatedSprite = get_node("/root/Main/Player/BodyPivot/AnimatedSprite2D")
@onready var healthBar = get_node("/root/Main/HUD/InLevel/HealthBar")
@onready var healthBarText = get_node("/root/Main/HUD/InLevel/HealthBar/HealthLabel")

func _ready():
	screen_size = get_viewport_rect().size
	hide()

func start(pos):
	position = pos
	show()
	#$CollisionShape2D.disabled = false

var look_direction := Vector2.RIGHT:
	set(value):
		look_direction = value
		set_look_direction(value)

func set_dead(value: bool) -> void:
	set_process_input(not value)
	set_physics_process(not value)
	$CollisionPolygon2D.disabled = value

func set_look_direction(value: Vector2) -> void:
	direction_changed.emit(value)

#func _on_body_entered(body: CharacterBody2D) -> void:
func _on_body_entered(body) -> void:
	if body == self:
		return
	if body is CharacterBody2D:
		health -= 10
		Global.direction_animation_update("stagger")
		healthBar.value = health
		healthBarText.text = str(int(health)) + "/" + str(int(Global.max_player_health))
		if health <= 0.0:
			hide() # Player disappears after being hit.
			health_depleted.emit()
