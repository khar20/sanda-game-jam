extends StaticBody2D

@export var mass: float = 1000.0                    # Used for gravitational pull
@export var radius: float = 32.0                    # For collision or visual scale
@export var sprite_texture: Texture                 # Assign via Inspector

#@onready var gravity_field: Area2D = preload("res://GravityField.tscn").instantiate()

func _ready():
	position = Vector2(randf_range(-200, 200), randf_range(-200, 200))
		
#	add_child(gravity_field)
#	gravity_field.position = Vector2.ZERO
#	gravity_field.set("gravity", mass)
#	gravity_field.set("gravity_point", true)
