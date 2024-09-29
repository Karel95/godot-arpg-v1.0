extends "res://scenes/collectables/collectable.gd"

@onready var animations = $AnimationPlayer

func collect(inventory: Inventory):
	z_index = 1
	animations.play("collect")
	await animations.animation_finished
	super.collect(inventory)
