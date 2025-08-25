extends StaticBody2D

@export var mass: float = 1000.0
@export var radius: float = 32.0
@export var sprite_texture: Texture

func _ready():
	mass = randf_range(500, 2000)
	radius = randf_range(16, 64)
	var collision = $CollisionShape2D.shape as CircleShape2D
	collision.radius = radius
	var gravity_shape = $GravityArea/CollisionShape2D.shape as CircleShape2D
	gravity_shape.radius = radius * 5
	$Sprite2D.texture = sprite_texture
	$Sprite2D.scale = Vector2.ONE * (radius / 32)
	$GravityArea.gravity_point = true
	$GravityArea.gravity = mass * 1000000 # simulate based on mass agent
