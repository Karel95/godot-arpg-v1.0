extends CharacterBody2D

@export var speed:int = 100
@onready var animations = $AnimationPlayer

func handleInput():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDirection * speed
	

func updateAnimation():
	if velocity.length() == 0:
		if animations.is_playing():
			animations.stop()
	else:
		var direction = "_down"
		var normalized_velocity = velocity.normalized()
		if normalized_velocity.x < -0.8:
			direction = "_left"
		elif normalized_velocity.x > 0.8:
			direction = "_right"
		elif normalized_velocity.y < -0.8:
			direction = "_up"
			
		animations.play("walk" + direction)

func _physics_process(delta):
	handleInput()
	move_and_slide()
	updateAnimation()
	


func _on_hurt_box_area_2d_area_entered(area):
	if area.name == "hitBox_Area2D":
		print(area.get_parent().name)
