extends CanvasLayer

# Notifies `Main` node that the button has been pressed
signal start_game

@onready var tileMap = get_node("/root/Main/Tilemap")

#var titleText = "The Road to Rainbow"
func _ready():
	$Rainbow.hide()
	tileMap.hide()

func show_game_over():
	$Rainbow.hide()
	tileMap.get_node("Clouds V1").enabled = false
	tileMap.get_node("Clouds V2").enabled = false
	tileMap.get_node("Clouds V3").enabled = false
	tileMap.get_node("Clouds V4").enabled = false
	tileMap.get_node("Levers").enabled = false
	tileMap.get_node("Heart").enabled = false
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	await $MessageTimer.timeout

	$TitleLabel.text = "The Road to\nRainbow"
	$TitleLabel.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()
	
func show_win():
	
	$Rainbow.hide()
	tileMap.get_node("Clouds V1").enabled = false
	tileMap.get_node("Clouds V2").enabled = false
	tileMap.get_node("Clouds V3").enabled = false
	tileMap.get_node("Clouds V4").enabled = false
	tileMap.get_node("Levers").enabled = false
	tileMap.get_node("Heart").enabled = false
	show_message("You win!")
	
	# Wait until the MessageTimer has counted down.
	#await $MessageTimer.timeout
	#await get_tree().create_timer(2.0).timeout

	$TitleLabel.text = "The Road to\nRainbow"
	$TitleLabel.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()

func show_message(text):
	$TitleLabel.text = text
	$TitleLabel.show()
	$MessageTimer.start()

func _on_start_button_pressed() -> void:
	$StartButton.hide()
	$TitleLabel.hide()
	$Rainbow.texture = load("res://rainbow_hud/rainbow_0.png")
	$Rainbow.show()
	tileMap.show()
	start_game.emit()

func _on_message_timer_timeout() -> void:
	$TitleLabel.hide()
