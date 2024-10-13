extends CharacterBody2D

signal healthChanged

@export var speed:int = 100
@onready var animations = $AnimationPlayer

@export var maxHealth:int =3
@onready var currentHealth:int = maxHealth

@export var knockbackPower:int = 2000
@onready var effects = $effects_AnimationPlayer

@onready var hurtBox = $hurtBox_Area2D

@export var inventory: Inventory

@onready var weapon = $weapon

var isHurt:bool = false
var lastAnimDirection:String = "_down"
var isAttacking:bool = false

func _ready():
	effects.play("RESET")
	weapon.disable()

func handleInput():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDirection * speed
	
	if Input.is_action_just_pressed("attack"):
		animations.play("attack" + lastAnimDirection)
		isAttacking = true
		weapon.enable()
		await animations.animation_finished
		isAttacking = false
		weapon.disable()
		animations.play("attack_reset")

func updateAnimation():
	# Si el personaje está atacando, no reproducir animaciones de movimiento
	if isAttacking:
		if not animations.is_playing():
			# Cuando termina la animación de ataque, restablece el estado
			isAttacking = false
		return  # Sale de la función si está atacando
	if velocity.length() == 0:
		if animations.is_playing():
			animations.stop()
	else:
		var direction = ""
		var normalized_velocity = velocity.normalized()
		if abs(normalized_velocity.y) > abs(normalized_velocity.x):
			if normalized_velocity.y < -0.8:
				direction = "_up"
			elif normalized_velocity.y > 0.8:
				direction = "_down"
		else:
			if normalized_velocity.x < -0.8:
				direction = "_left"
			elif normalized_velocity.x > 0.8:
				direction = "_right"
		if direction != "":
			animations.play("walk" + direction)
		lastAnimDirection = direction



func _physics_process(delta):
	handleInput()
	move_and_slide()
	updateAnimation()
	if !isHurt:
		for area in hurtBox.get_overlapping_areas():
			if area.name == "hitBox_Area2D":
				hurtByEnemy(area)

func hurtByEnemy(area):
	currentHealth -= 1
	if currentHealth < 0:
		currentHealth = maxHealth
	healthChanged.emit(currentHealth)
	isHurt = true
	knockback(area.get_parent().velocity)
	effects.play("hurt-blink")
	

func _on_hurt_box_area_2d_area_entered(area):
	if area.has_method('collect'):
		area.collect(inventory)
	

func knockback(enemyVelocity:Vector2):
	var knockbackDirection = (enemyVelocity - velocity).normalized() * knockbackPower
	velocity = knockbackDirection
	move_and_slide()

func _on_effects_animation_player_animation_finished(anim_name):
	effects.play("RESET")
	isHurt = false

func _on_hurt_box_area_2d_area_exited(area):
	pass
	
