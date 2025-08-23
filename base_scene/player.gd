extends CharacterBody2D

@export var gravity_strength: float = 400.0
@export var move_speed: float = 150.0
@export var jump_speed: float = 300.0

@onready var ship: Node2D = $"../SpaceStation"

func _physics_process(delta: float) -> void:
	# "Down" points toward the ship's hull based on its rotation
	var down: Vector2 = Vector2.DOWN.rotated(ship.rotation).normalized()
	var tangent: Vector2 = down.orthogonal().normalized()  # direction to walk along the ring

	# Decompose current velocity into local (tangent/perp) components
	var v_tan: float = velocity.dot(tangent)
	var v_perp: float = velocity.dot(down)

	# Apply gravity along "down"
	v_perp += gravity_strength * delta

	# Input along the tangent (A/D or ←/→)
	var input_axis := Input.get_axis("ui_left", "ui_right")
	if abs(input_axis) > 0.01:
		v_tan = input_axis * move_speed
	else:
		v_tan = lerp(v_tan, 0.0, 0.1)

	# Jump opposite to "down" when grounded
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		v_perp = -jump_speed

	# Recompose into global velocity and tell Godot what "up" is
	velocity = tangent * v_tan + down * v_perp
	up_direction = -down

	# Godot 4: no args; uses velocity/up_direction/motion_mode
	move_and_slide()
