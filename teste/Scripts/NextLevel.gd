extends Area2D
@onready var portal_collision: CollisionShape2D = $CollisionShape2D


func _on_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene_to_file("res://Scenes/Fase2.tscn")
