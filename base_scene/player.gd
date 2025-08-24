extends CharacterBody2D

@export var speed: float = 60.0
@export var gravity_strength: float = 100.0
@export var center: Vector2

func _ready() -> void:
	floor_max_angle = 10
	

func _physics_process(delta):
	var raw_to_center = center - global_position
	var to_center: Vector2
	if raw_to_center.length_squared() > 0.000001:
		to_center = raw_to_center.normalized()
	else:
		to_center = Vector2(0, -1)

	velocity += to_center * -gravity_strength * delta

	if is_on_floor():
		var normal = get_floor_normal()
		var tangent = Vector2(-normal.y, normal.x)
		var direction_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		velocity += tangent * direction_input * speed * delta

		rotation = normal.angle() + deg_to_rad(90)

	up_direction = to_center
	move_and_slide()
