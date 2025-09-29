extends Node

var main_game_running = false
var boss_level = false
var max_player_health = 100.0

var lever_number = 0

@onready var hud = get_node("/root/Main/HUD")
@onready var rainbow = get_node("/root/Main/HUD/Rainbow")
@onready var player = get_node("/root/Main/Player")
@onready var healthBar = get_node("/root/Main/Player/HealthBar")
@onready var tileMap = get_node("/root/Main/Tilemap")
@onready var tileMapLevers = get_node("/root/Main/Tilemap/Levers")
@onready var tileMapHeart = get_node("/root/Main/Tilemap/Heart")

var tile_cell_size = Vector2(128,128)

var minion_locations = [Vector2(5,5),Vector2(6,5),Vector2(11,3),Vector2(13,4),Vector2(15,4),Vector2(16,3),Vector2(10,10),Vector2(11,10),Vector2(12,10),Vector2(10,11),Vector2(11,11),Vector2(12,11)]

func spawn_mob(scale, health, position):
	%PathFollow2D.progress_ratio = randf()
	var new_mob = preload("res://mobs/mob.tscn").instantiate()
	new_mob.global_position = %PathFollow2D.global_position
	new_mob.global_scale = scale
	new_mob.health = health
	new_mob.position = position
	add_child(new_mob)

func _ready():
	pass
	
func _process(delta: float) -> void:
	var interactive_collision = $Player/HurtBox.get_overlapping_bodies()
	var area_collision = $Player/HurtBox.get_overlapping_areas()
	for object in interactive_collision:
		if object.name == "Levers":
			if Input.is_action_just_pressed("interact"):
				if lever_number == 0:
					tileMapLevers.set_cell(Vector2i(5,6),1,Vector2i(0,1))
					tileMap.get_node("Clouds V1").enabled = false
					tileMap.get_node("Clouds V2").enabled = true
					lever_number += 1
					return
				elif lever_number == 1:
					tileMapLevers.set_cell(Vector2i(16,2),1,Vector2i(0,1))
					tileMap.get_node("Clouds V2").enabled = false
					tileMap.get_node("Clouds V3").enabled = true
					lever_number += 1
					return
				elif lever_number == 2:
					tileMapLevers.set_cell(Vector2i(11,12),1,Vector2i(0,1))
					tileMap.get_node("Clouds V3").enabled = false
					tileMap.get_node("Clouds V4").enabled = true
					lever_number += 1
					return
		if object.name == "Heart":
			tileMapHeart.erase_cell(Vector2i(4,11))
			max_player_health += 10
			healthBar.max_value = max_player_health
			if player.health < max_player_health:
				if player.health <= max_player_health - 25.0:
					player.health += 25.0
				else:
					player.health = max_player_health
			healthBar.value = player.health
			hud.show_message("Health +10")
	for area in area_collision:
		if area.name == "Boss Area" and boss_level == false:
			tileMap.get_node("Clouds V4").enabled = false
			tileMap.get_node("Clouds V1").enabled = true
			var boss_position = tile_cell_size * Vector2(18,14)
			spawn_mob(Vector2(3,3),6,boss_position)
			boss_level = true
	var mob_group = get_tree().get_nodes_in_group("mobs").is_empty()
	if mob_group and boss_level:
		$HUD.show_win()
		$Player.hide()
	#if main_game_running and mob_group and boss_level:
		#if Global.level_count == 1:
			#end_level()
			#new_level("2",2)
		#elif Global.level_count == 2:
			#end_level()
			#new_level("3",3)
		#elif Global.level_count == 3:
			#end_level()
			#new_level("4",4)
		#elif Global.level_count == 4:
			#end_level()
			#new_level("5",6)
		#elif Global.level_count == 5:
			#end_level()
			#new_level("6",7)
		#elif Global.level_count == 6:
			#end_level()
			#new_level("7",8)
		#elif Global.level_count == 7:
			#await get_tree().create_timer(0.5).timeout
			#Global.level_count += 1
			#main_game_running = false
			#boss_level = false
			#$HUD.show_win()
			#$Player.hide()
	#elif main_game_running and mob_group:
		#if Global.level_count == 1:
			#spawn_mob(Vector2(1.5,1.5),4)
			#boss_level = true
		#elif Global.level_count == 2:
			#spawn_mob(Vector2(2,2),5)
			#boss_level = true
		#elif Global.level_count == 3:
			#spawn_mob(Vector2(2.5,2.5),6)
			#boss_level = true
		#elif Global.level_count == 4:
			#spawn_mob(Vector2(2.5,2.5),7)
			#boss_level = true
		#elif Global.level_count == 5:
			#spawn_mob(Vector2(3,3),8)
			#boss_level = true
		#elif Global.level_count == 6:
			#spawn_mob(Vector2(3.5,3.5),9)
			#boss_level = true
		#elif Global.level_count == 7:
			#spawn_mob(Vector2(4,4),10)
			#boss_level = true

func _on_player_health_depleted():
	get_tree().call_group("mobs", "queue_free")
	main_game_running = false
	$HUD.show_game_over()

func new_game() -> void:
	player.health = max_player_health
	healthBar.value = player.health
	tileMap.get_node("Clouds V1").enabled = true
	tileMap.get_node("Clouds V2").enabled = false
	tileMap.get_node("Clouds V3").enabled = false
	tileMap.get_node("Clouds V4").enabled = false
	tileMap.get_node("Levers").enabled = true
	tileMap.get_node("Heart").enabled = true
	$Player.start($StartPosition.position)
	for vector in minion_locations:
		var location = vector * tile_cell_size
		spawn_mob(Vector2(1,1),3,location)
	main_game_running = true

func new_level(level: String, mob_health):
	hud.show_message("Level " + level + "\n(Health +10)")
	#for i in range(6):
		#spawn_mob(Vector2(1,1),mob_health)
		#await get_tree().create_timer(1).timeout
	main_game_running = true

func end_level():
	rainbow.texture = load("res://rainbow_hud/rainbow_" + str(Global.level_count) + ".png")
	#max_player_health += 10
	#healthBar.max_value = max_player_health
	#if player.health < max_player_health:
		#if player.health <= max_player_health - 25.0:
			#player.health += 25.0
		#else:
			#player.health = max_player_health
	#healthBar.value = player.health
	main_game_running = false
	boss_level = false
	Global.level_count += 1
