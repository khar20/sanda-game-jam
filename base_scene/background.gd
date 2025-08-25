extends Sprite2D

@export var rotation_speed: float = 10.0

func _process(delta: float) -> void:
	rotation_degrees += rotation_speed * delta
