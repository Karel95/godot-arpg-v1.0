extends Button

@onready var backgroundSprite: Sprite2D = $background
@onready var container: CenterContainer = $CenterContainer

@onready var inventory = preload("res://inventory/playerInventory.tres")

var itemsPanel: ItemsPanel
var index: int

func insert(items: ItemsPanel):
	itemsPanel = items
	backgroundSprite.frame = 1
	container.add_child(itemsPanel)
	
	if !itemsPanel.inventorySlot || inventory.slots[index] == itemsPanel.inventorySlot:
		return
	
	inventory.insertSlot(index, itemsPanel.inventorySlot)

func takeItem():
	var item = itemsPanel
	
	inventory.removeSlot(itemsPanel.inventorySlot)
	
	return item
	

func isEmpty():
	return !itemsPanel

func clear() -> void:
	if itemsPanel:
		container.remove_child(itemsPanel)
		itemsPanel = null
		
	backgroundSprite.frame = 0
	

