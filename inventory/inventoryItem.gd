extends Resource

class_name InventoryItem

@export var name: String
@export var texture: Texture2D
@export var maxAmountPerStack: int = 10

func use(player: Player) -> void:
	pass

