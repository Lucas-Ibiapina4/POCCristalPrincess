extends Node2D

@onready var cristal_scene = preload("res://Scenes/Cristal.tscn")

# Called when the node enters the scene tree for the first time.
func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var cristal_instance = cristal_scene.instantiate()
			add_child(cristal_instance)
			cristal_instance.global_position = get_global_mouse_position()
