extends StaticBody2D

@export var mass: float = 1000.0                    # Used for gravitational pull
@export var radius: float = 32.0                    # For collision or visual scale
@export var sprite_texture: Texture                 # Assign via Inspector

#@onready var gravity_field: Area2D = preload("res://GravityField.tscn").instantiate()

func _ready():
	# Optional: Add a Sprite to represent the planet
	if sprite_texture:
		var sprite = Sprite2D.new()
		sprite.texture = sprite_texture
		sprite.centered = true
		add_child(sprite)
	# If using collision:
	if not has_node("CollisionShape2D"):
		var shape = CollisionShape2D.new()
		var circle = CircleShape2D.new()
		circle.radius = radius
		shape.shape = circle
		add_child(shape)
		
#	add_child(gravity_field)
#	gravity_field.position = Vector2.ZERO
#	gravity_field.set("gravity", mass)
#	gravity_field.set("gravity_point", true)
