extends Button

@onready var background_sprite: Sprite2D = $background
@onready var items_panel: ItemsPanel = $CenterContainer/ItemsPanel

func update_to_slot(slot: InventorySlot) -> void:
	if !slot.item:
		items_panel.visible = false
		background_sprite.frame = 0
		return
	
	items_panel.inventorySlot = slot
	items_panel.update(slot)
	items_panel.visible = true
	background_sprite.frame = 1
	

