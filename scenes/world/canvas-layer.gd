extends CanvasLayer

@onready var inventory = $InventoryGUI

var isPaused:bool = false

func pause_game():
	get_parent().get_tree().paused = true
	isPaused = true

func unPause_game():
	get_parent().get_tree().paused = false
	isPaused = false

func _input(event):
#pause
	if event.is_action_pressed("pause"):
		if isPaused:
			unPause_game()
		else:
			pause_game()
#inventory
	if event.is_action_pressed("toggle_inventory"):
		if inventory.isOpen:
			inventory.close()
		else:
			inventory.open()
