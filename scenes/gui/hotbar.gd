extends HBoxContainer

@onready var inventory: Inventory = preload("res://inventory/playerInventory.tres")
@onready var slots: Array = get_children()

func _ready():
	update()
	inventory.updated.connect(update)

func update():
	for i in range (slots.size()):
		var inventorySlot: InventorySlot = inventory.slots[i]
		slots[i].update_to_slot(inventorySlot)
		
	#for i in range(min(inventory.slots.size(), slots.size())):
		#var inventorySlot: InventorySlot = inventory.slots[i]
		#if !inventorySlot.item: continue
		#
		#var itemsPanel: ItemsPanel = slots[i].itemsPanel
		#if !itemsPanel:
			#itemsPanel = itemsPanelClass.instantiate()
			#slots[i].insert(itemsPanel)
			#
		#itemsPanel.inventorySlot = inventorySlot
		#itemsPanel.update(inventorySlot)
		
