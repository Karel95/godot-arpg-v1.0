extends Resource

class_name Inventory

signal updated
signal use_item

@export var slots:Array[InventorySlot]

var index_of_last_used_item: int = -1

func insert(item: InventoryItem):
	var remaining_amount = 1  # Asumimos que quieres insertar 1 ítem inicialmente
	
	# Buscar los slots que ya tienen el ítem
	var itemSlots = slots.filter(func(slot): return slot.item == item)
	
	# Si ya hay slots con el ítem, intenta llenarlos hasta 10
	if !itemSlots.is_empty():
		for slot in itemSlots:
			if slot.amount < 10:
				var space_left = 10 - slot.amount
				var amount_to_add = min(remaining_amount, space_left)
				slot.amount += amount_to_add
				remaining_amount -= amount_to_add
				# Si ya hemos insertado todos los ítems, salimos de la función
				if remaining_amount <= 0:
					updated.emit()
					return
	
	# Si quedan ítems por insertar, busca slots vacíos
	while remaining_amount > 0:
		var emptySlots = slots.filter(func(slot): return slot.item == null)
		
		# Si hay slots vacíos disponibles
		if !emptySlots.is_empty():
			var slot_to_fill = emptySlots[0]
			slot_to_fill.item = item
			slot_to_fill.amount = min(remaining_amount, 10)  # Llena el slot con la cantidad máxima posible
			remaining_amount -= slot_to_fill.amount
		else:
			break  # No hay más slots vacíos disponibles
	
	updated.emit()




func removeSlot(inventorySlot: InventorySlot):
	var index = slots.find(inventorySlot)
	if index < 0: return
	
	remove_at_index(index)
	

func remove_at_index(index: int) -> void:
	slots[index] = InventorySlot.new()
	updated.emit()

func insertSlot(index: int, inventorySlot: InventorySlot):
	slots[index] = inventorySlot
	
	updated.emit()

func use_item_at_index(index: int) -> void:
	if index < 0 || index >= slots.size() || !slots[index].item: return
	
	var slot = slots[index]
	index_of_last_used_item = index
	use_item.emit(slot.item)
	

func remove_last_used_item() -> void:
	if index_of_last_used_item < 0: return
	
	var slot = slots[index_of_last_used_item]
	
	if slot.amount > 1:
		slot.amount -= 1
		updated.emit()
		return
		
	
	remove_at_index(index_of_last_used_item)
	
