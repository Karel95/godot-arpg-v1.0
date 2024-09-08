extends Node2D

@onready var heartsContainer = $CanvasLayer/HeartsContainer_HBoxContainer
@onready var player = $TileMap/Player


func _ready():
	heartsContainer.setMaxHearts(player.maxHealth)
	player.healthChanged.connect(heartsContainer.updateHearts)
	

