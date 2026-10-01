extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -600.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var mirror_placeholder: Marker2D = $Mirror_placeholder
@onready var cristal_scene = preload("res://Scenes/Cristal.tscn")
var array_of_cristals = []
var cristal_distance = 80

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		

	# Get the input direction (0 ; -1 ; 1)
	var direction := Input.get_axis("move_left", "move_right")


	# Flip Sprite
	if direction > 0:
		animated_sprite.flip_h = false
		mirror_placeholder.position.x = cristal_distance
	elif direction < 0:
		animated_sprite.flip_h = true
		mirror_placeholder.position.x = -cristal_distance


	# Play Animation
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("default")
		else:
			animated_sprite.play("walk")
	else:
		animated_sprite.play("jump")
	# Apply Direction
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if Input.is_action_just_pressed("Create_Cristal"):
		CreateCristal()
	
	if Input.is_action_just_pressed("Remove_Cristal"):
		RemoveCristal()

	move_and_slide()

func CreateCristal():
	var cristal_instance = cristal_scene.instantiate()
	add_sibling(cristal_instance)
	cristal_instance.global_position = mirror_placeholder.global_position
	array_of_cristals.append(cristal_instance)

func RemoveCristal():
	if array_of_cristals.size() > 0:
		var cristal = array_of_cristals.pop_back()
		cristal.queue_free()
