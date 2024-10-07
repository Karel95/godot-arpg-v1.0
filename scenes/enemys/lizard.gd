extends CharacterBody2D

@export var speed = 25
@export var limit = 0.5
@export var endPoint = Marker2D

@onready var animations = $AnimatedSprite2D

var isDying = false  # Variable para controlar el estado de muerte
var startPosition
var endPosition

func _ready():
	startPosition = position
	endPosition = endPoint.global_position


func changeDirection():
	var tempEnd = endPosition
	endPosition = startPosition
	startPosition = tempEnd
	

func updateVelocity():
	var moveDirection = endPosition - position
	if moveDirection.length() < limit:
		changeDirection()
	
	velocity = moveDirection.normalized() * speed
	

func updateAnimations():
	# Si el personaje está muriendo, no reproducir ninguna animación de movimiento
	if isDying:
		return  # Sale de la función si el personaje está muriendo
	if velocity.length() == 0:
		if animations.is_playing():
			animations.stop()
	else:
		var direction = "Down"
		var normalized_velocity = velocity.normalized()
		if normalized_velocity.x < -0.8:
			direction = "Left"
		elif normalized_velocity.x > 0.8:
			direction = "Right"
		elif normalized_velocity.y < -0.8:
			direction = "Up"
			
		animations.play("walk" + direction)


func handleCollision():
	pass

func _physics_process(delta):
	updateVelocity()
	move_and_slide()
	updateAnimations()
	handleCollision()
	

func _on_hurt_box_area_2d_area_entered(area):
	# Verifica si el área que entró pertenece al grupo 'weapon'
	if area.is_in_group("weapon"):
		$hitBox_Area2D.set_deferred("monitorable", false)
		isDying = true
		animations.play("death")
		await animations.animation_finished
		queue_free()
