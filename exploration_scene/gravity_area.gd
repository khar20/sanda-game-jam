extends Area2D

@export var gravity_strength : float = 1000.0
@export var planet_position : Vector2 = Vector2(400, 300)
@export var planet_mass : float = 500.0

func _on_Area2D_body_exited(body: Node2D) -> void:
	if body is RigidBody2D:
		remove_gravity(body)

func apply_gravity(body: RigidBody2D) -> void:
	print("grav")
	var direction_to_planet = planet_position - body.global_position
	var distance = direction_to_planet.length()
	var gravity_force = gravity_strength * planet_mass / (distance * distance)
	var gravity_acceleration = direction_to_planet.normalized() * gravity_force

	body.apply_force(gravity_acceleration * body.mass)

func remove_gravity(body: RigidBody2D) -> void:
	print("a")
	#body.clear_forces()

func _on_body_entered(body: Node2D) -> void:
	print("a")
	if body is RigidBody2D:
		apply_gravity(body)

func _on_body_exited(body: Node2D) -> void:
	if body is RigidBody2D:
		remove_gravity(body)
