extends Control

var isOpen:bool = false

@onready var inventory: Inventory = preload("res://inventory/playerInventory.tres")
@onready var itemsPanelClass = preload("res://scenes/gui/items_panel.tscn")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var itemInHand: ItemsPanel

func _ready():
	connectSlots()
	inventory.updated.connect(update)
	update()
	visible = isOpen

func update():
	for i in range(min(inventory.slots.size(), slots.size())):
		var inventorySlot: InventorySlot = inventory.slots[i]
		if !inventorySlot.item: continue
		
		var itemsPanel: ItemsPanel = slots[i].itemsPanel
		if !itemsPanel:
			itemsPanel = itemsPanelClass.instantiate()
			slots[i].insert(itemsPanel)
			
		itemsPanel.inventorySlot = inventorySlot
		itemsPanel.update(inventorySlot)

func open():
	visible = true
	isOpen = true
	

func close():
	visible = false
	isOpen = false
	

func connectSlots():
	for i in range(slots.size()):
		var slot = slots[i]
		slot.index = i
		
		var callable = Callable(onSlotClicked)
		callable = callable.bind(slot)
		slot.pressed.connect(callable)

func onSlotClicked(slot):
	if slot.isEmpty() && itemInHand:
		insertItemInSlot(slot)
		return
	
	if !itemInHand:
		takeItemFromSlot(slot)

func takeItemFromSlot(slot):
	itemInHand = slot.takeItem()
	add_child(itemInHand)
	updateItemInHand()

func insertItemInSlot(slot):
	var item = itemInHand
	
	remove_child(itemInHand)
	itemInHand = null
	
	slot.insert(item)

func updateItemInHand():
	if !itemInHand: return
	itemInHand.global_position = get_global_mouse_position() - itemInHand.size/2

func _input(event):
	updateItemInHand()


