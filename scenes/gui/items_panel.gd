extends Panel

class_name ItemsPanel

@onready var itemSprite: Sprite2D = $item
@onready var amountLabel: Label = $Label

var inventorySlot

func update(slot: InventorySlot):
	if !inventorySlot || !inventorySlot.item: return
	
	itemSprite.visible = true
	itemSprite.texture = slot.item.texture
	amountLabel.visible = true
	amountLabel.text = str(slot.amount)
