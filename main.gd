extends Node

var main_game_running = false
var boss_level = false
var max_player_health = 100.0

@onready var hud = get_node("/root/Main/HUD")
@onready var rainbow = get_node("/root/Main/HUD/Rainbow")
@onready var player = get_node("/root/Main/Player")
@onready var healthBar = get_node("/root/Main/Player/HealthBar")

func spawn_mob(scale, health):
	%PathFollow2D.progress_ratio = randf()
	var new_mob = preload("res://mobs/mob.tscn").instantiate()
	new_mob.global_position = %PathFollow2D.global_position
	new_mob.global_scale = scale
	new_mob.health = health
	add_child(new_mob)

func _ready():
	pass
	
func _process(delta: float) -> void:
	var mob_group = 	get_tree().get_nodes_in_group("mobs").is_empty()
	if main_game_running and mob_group and boss_level:
		if Global.level_count == 1:
			end_level()
			new_level("2",2)
		elif Global.level_count == 2:
			end_level()
			new_level("3",3)
		elif Global.level_count == 3:
			end_level()
			new_level("4",4)
		elif Global.level_count == 4:
			end_level()
			new_level("5",6)
		elif Global.level_count == 5:
			end_level()
			new_level("6",7)
		elif Global.level_count == 6:
			end_level()
			new_level("7",8)
		elif Global.level_count == 7:
			await get_tree().create_timer(0.5).timeout
			Global.level_count += 1
			main_game_running = false
			boss_level = false
			$HUD.show_win()
			$Player.hide()
	elif main_game_running and mob_group:
		if Global.level_count == 1:
			spawn_mob(Vector2(1.5,1.5),4)
			boss_level = true
		elif Global.level_count == 2:
			spawn_mob(Vector2(2,2),5)
			boss_level = true
		elif Global.level_count == 3:
			spawn_mob(Vector2(2.5,2.5),6)
			boss_level = true
		elif Global.level_count == 4:
			spawn_mob(Vector2(2.5,2.5),7)
			boss_level = true
		elif Global.level_count == 5:
			spawn_mob(Vector2(3,3),8)
			boss_level = true
		elif Global.level_count == 6:
			spawn_mob(Vector2(3.5,3.5),9)
			boss_level = true
		elif Global.level_count == 7:
			spawn_mob(Vector2(4,4),10)
			boss_level = true

func _on_player_health_depleted():
	get_tree().call_group("mobs", "queue_free")
	main_game_running = false
	$HUD.show_game_over()

func new_game() -> void:
	player.health = max_player_health
	healthBar.value = player.health
	$Player.start($StartPosition.position)
	for i in range(6):
		spawn_mob(Vector2(1,1),1)
		await get_tree().create_timer(1).timeout
	main_game_running = true

func new_level(level: String, mob_health):
	hud.show_message("Level " + level + "\n(Health +10)")
	for i in range(6):
		spawn_mob(Vector2(1,1),mob_health)
		await get_tree().create_timer(1).timeout
	main_game_running = true

func end_level():
	rainbow.texture = load("res://rainbow_hud/rainbow_" + str(Global.level_count) + ".png")
	max_player_health += 10
	healthBar.max_value = max_player_health
	if player.health < max_player_health:
		if player.health <= max_player_health - 25.0:
			player.health += 25.0
		else:
			player.health = max_player_health
	healthBar.value = player.health
	main_game_running = false
	boss_level = false
	Global.level_count += 1
