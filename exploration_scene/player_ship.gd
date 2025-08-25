extends RigidBody2D

@export var thrust_power : float = 300.0
@export var gravity_strength : float = 1000.0
@export var planet_position : Vector2 = Vector2(400, 300)
@export var planet_mass : float = 500.0

#@onready var thruster_marker = $Marker2D
#@onready var thruster_animation = $AnimatedSprite2D

var thrust_direction : Vector2 = Vector2.ZERO

func _ready():
	pass

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	var direction_to_planet = planet_position - global_position
	var distance = direction_to_planet.length()
	var gravity_force = gravity_strength * planet_mass / (distance * distance)
	var gravity_acceleration = direction_to_planet.normalized() * gravity_force

	state.apply_force(gravity_acceleration * mass)

	if thrust_direction != Vector2.ZERO:
		var thrust_force = thrust_direction * thrust_power
		state.apply_force(thrust_force)

func handle_input():
	thrust_direction = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		thrust_direction.y -= 1
	if Input.is_action_pressed("ui_down"):
		thrust_direction.y += 1
	if Input.is_action_pressed("ui_left"):
		thrust_direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		thrust_direction.x += 1

	if thrust_direction != Vector2.ZERO:
		thrust_direction = thrust_direction.normalized()

#func update_visuals():
#	if thrust_direction != Vector2.ZERO:
#		thruster_marker.visible = true
#		thruster_animation.play("thrust")
#	else:
#		thruster_marker.visible = false
#		thruster_animation.stop()
