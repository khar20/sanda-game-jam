extends AnimatableBody2D

func _on_button_pressed() -> void:
	print("Button pressed!")
	get_tree().change_scene_to_file("res://exploration_scene.tscn")	
