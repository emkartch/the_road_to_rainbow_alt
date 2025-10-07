extends Node

var boss_level = false

var lever_number = 0

@onready var hud = get_node("/root/Main/HUD")
@onready var rainbow = get_node("/root/Main/HUD/InLevel/RainbowIcon")
@onready var player = get_node("/root/Main/Player")
@onready var healthBar = get_node("/root/Main/HUD/InLevel/HealthBar")
@onready var healthBarText = get_node("/root/Main/HUD/InLevel/HealthBar/HealthLabel")
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
	if Global.main_game_running:
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
				Global.max_player_health += 25
				healthBar.max_value = Global.max_player_health
				healthBar.size.x = Global.max_player_health * 4
				if player.health < Global.max_player_health:
					if player.health <= Global.max_player_health - 25.0:
						player.health += 25.0
					else:
						player.health = Global.max_player_health
				healthBar.value = player.health
				healthBarText.text = str(int(player.health)) + "/" + str(int(Global.max_player_health))
				hud.show_message("Health +25")
		for area in area_collision:
			if area.name == "Boss Area" and boss_level == false:
				tileMap.get_node("Clouds V4").enabled = false
				tileMap.get_node("Clouds V1").enabled = true
				var boss_position = tile_cell_size * Vector2(18,14)
				spawn_mob(Vector2(3,3),6,boss_position)
				boss_level = true
		var mob_group = get_tree().get_nodes_in_group("mobs").is_empty()
		if mob_group and boss_level:
			Global.main_game_running = false
			$HUD.show_win()
			$Player.hide()

func _on_player_health_depleted():
	get_tree().call_group("mobs", "queue_free")
	Global.main_game_running = false
	$HUD.show_game_over()

func new_game() -> void:
	player.health = Global.max_player_health
	healthBar.value = player.health
	healthBarText.text = str(int(player.health)) + "/" + str(int(Global.max_player_health))
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
	Global.main_game_running = true

func new_level(level: String, mob_health):
	hud.show_message("Level " + level + "\n(Health +10)")
	Global.main_game_running = true

func end_level():
	rainbow.texture = load("res://rainbow_hud/rainbow_" + str(Global.level_count) + ".png")
	Global.main_game_running = false
	boss_level = false
	Global.level_count += 1
