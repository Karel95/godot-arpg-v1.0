extends "res://scenes/collectables/collectable.gd"

@onready var animations = $AnimationPlayer

func collect():
	z_index = 1
	animations.play("collect")
	await animations.animation_finished
	super.collect()
