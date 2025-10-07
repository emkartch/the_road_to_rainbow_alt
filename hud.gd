extends CanvasLayer

# Notifies `Main` node that the button has been pressed
signal start_game

@onready var tileMap = get_node("/root/Main/Tilemap")
@onready var theme = preload("res://theme/trtr_theme.tres")

#var titleText = "The Road to Rainbow"
func _ready():
	$InLevel.hide()
	$Settings.hide()
	tileMap.hide()

func show_game_over():
	$InLevel.hide()
	tileMap.get_node("Clouds V1").enabled = false
	tileMap.get_node("Clouds V2").enabled = false
	tileMap.get_node("Clouds V3").enabled = false
	tileMap.get_node("Clouds V4").enabled = false
	tileMap.get_node("Levers").enabled = false
	tileMap.get_node("Heart").enabled = false
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	await $MessageTimer.timeout

	%TitleLabel.text = "The Road to\nRainbow"
	$TitleContainer.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$TitleButtonsContainer.show()
	
func show_win():
	$InLevel.hide()
	tileMap.get_node("Clouds V1").enabled = false
	tileMap.get_node("Clouds V2").enabled = false
	tileMap.get_node("Clouds V3").enabled = false
	tileMap.get_node("Clouds V4").enabled = false
	tileMap.get_node("Levers").enabled = false
	tileMap.get_node("Heart").enabled = false
	show_message("You win!")
	
	# Wait until the MessageTimer has counted down.
	await $MessageTimer.timeout

	%TitleLabel.text = "The Road to\nRainbow"
	$TitleContainer.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$TitleButtonsContainer.show()

func show_message(text):
	%TitleLabel.text = text
	$TitleContainer.show()
	$MessageTimer.start()

func _on_start_button_pressed() -> void:
	$TitleContainer.hide()
	$TitleButtonsContainer.hide()
	%RainbowIcon.texture = load("res://rainbow_hud/rainbow_0.png")
	$InLevel.show()
	tileMap.show()
	start_game.emit()

func _on_message_timer_timeout() -> void:
	$TitleContainer.hide()

func show_settings():
	get_tree().paused = true
	if Global.main_game_running == false:
		$TitleButtonsContainer.hide()
		$TitleContainer.hide()
	$Settings.show()

func _on_settings_icon_button_pressed() -> void:
	show_settings() 
	
func _on_settings_button_pressed() -> void:
	show_settings() 

func _on_return_icon_pressed() -> void:
	$Settings.hide()
	if Global.main_game_running == false:
		$TitleButtonsContainer.show()
		$TitleContainer.show()
	get_tree().paused = false

func _on_check_button_toggled(toggled_on: bool) -> void:
	# needs overridded
	# check button
	# health label
	# health bar
	if toggled_on:
		theme.set_font_size("font_size", "Label", 80)
		theme.set_font_size("font_size", "Button", 60)
		theme.set_font_size("font_size", "CheckButton", 60)
		%HealthBar.size.y = 50
		%HealthBar.position.y = 650
		%HealthLabel.add_theme_font_size_override("font_size", 50)
	elif not toggled_on:
		theme.set_font_size("font_size", "Label", 60)
		theme.set_font_size("font_size", "Button", 40)
		theme.set_font_size("font_size", "CheckButton", 40)
		%HealthBar.size.y = 35
		%HealthBar.position.y = 665
		%HealthLabel.add_theme_font_size_override("font_size", 30)
