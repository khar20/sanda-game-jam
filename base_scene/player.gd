extends CharacterBody2D

@export var speed: float = 60.0
@export var gravity_strength: float = 100.0
@export var jump_strength: float = 100.0
@export var center: Vector2
@export var rotation_speed: float = 10.0
@export var deceleration: float = 50.0
@export var max_speed: float = 100.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var is_jumping: bool = false
var last_direction: String = "idle"

func _physics_process(delta):
	var raw_to_center = center - global_position
	var to_center: Vector2

	if raw_to_center.length_squared() > 0.000001:
		to_center = raw_to_center.normalized()
	else:
		to_center = Vector2(0, -1)

	# Gravity directed toward center
	velocity += to_center * -gravity_strength * delta

	if is_on_floor():
		is_jumping = false
		var normal = get_floor_normal()
		var target_rotation = normal.angle() + deg_to_rad(90)
		var tangent = Vector2(-normal.y, normal.x)
		
		# Smooth rotation
		rotation = lerp_angle(rotation, target_rotation, rotation_speed * delta)
		
		# Horizontal movement
		var direction_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		if direction_input != 0:
			velocity += tangent * direction_input * speed * delta

			last_direction = "right" if direction_input > 0 else "left"

			animated_sprite.play("walk_" + last_direction)
			#animated_sprite.flip_h = (last_direction == "left")
		else:
			# Deceleration
			velocity.x = lerp(velocity.x, 0.0, deceleration * delta)
			animated_sprite.play("idle")
			#animated_sprite.flip_h = (last_direction == "left")

		# Jump
		if Input.is_action_just_pressed("ui_accept"):
			velocity += to_center * jump_strength
			is_jumping = true
			if last_direction == "idle":
				animated_sprite.play("idle")
			else:
				animated_sprite.play("jump_" + last_direction)

	else:
		# Play falling animation
		if velocity.y > 0:
			if last_direction == "idle":
				animated_sprite.play("idle")
			else:
				animated_sprite.play("jump_" + last_direction)
		else:
			if Input.get_action_strength("ui_left") == 0 and Input.get_action_strength("ui_right") == 0:
				animated_sprite.play("idle")

	# Maximum speed cap
	velocity = velocity.limit_length(max_speed)

	up_direction = to_center
	move_and_slide()
