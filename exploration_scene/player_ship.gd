extends RigidBody2D

var thrust_strength := 250.0

func _integrate_forces(state):
	var force := Vector2.ZERO

	if Input.is_action_pressed("ui_up"):
		force += Vector2(0, 1) * thrust_strength   # move down
	if Input.is_action_pressed("ui_down"):
		force += Vector2(0, -1) * thrust_strength   # move right
	if Input.is_action_pressed("ui_left"):
		force += Vector2(1, 0) * thrust_strength  # move up
	if Input.is_action_pressed("ui_right"):
		force += Vector2(-1, 0) * thrust_strength  # move left

	state.apply_force(force)
