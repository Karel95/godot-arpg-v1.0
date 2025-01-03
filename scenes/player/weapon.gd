extends Node2D

var weapon:Node2D

func _ready():
	if get_children().is_empty(): return
	weapon = get_children()[0]
	

func enable():
	if !weapon: return
	visible = true
	weapon.enable()

func disable():
	if !weapon: return
	visible = false
	weapon.disable()

func add_weapon(new_weapon) -> void:
	if weapon && weapon.name == new_weapon.name: return
	
	if weapon:
		remove_child(weapon)
	
	weapon = new_weapon
	add_child(new_weapon)
	
	disable()
