extends BaseScene

@onready var heartsContainer = $CanvasLayer/HeartsContainer_HBoxContainer
@onready var camera = $follow_cam

func _ready():
	super()
	camera.follow_node = player
	
	heartsContainer.setMaxHearts(player.maxHealth)
	player.healthChanged.connect(heartsContainer.updateHearts)
	
