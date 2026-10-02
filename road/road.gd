@tool
class_name Road
extends Node2D

@onready var sprite: Sprite2D = $Sprite

@onready var collision_shape: CollisionShape2D = $CollisionShape2D 

@onready var path: Path2D = $Path2D

func _ready():
	sprite.texture = texture
	collision_shape.shape = shape
	path.curve = curve
	

@export var texture: Texture2D:
	set(val):
		texture = val
		if sprite:
			sprite.texture = val
		
@export var shape: Shape2D:
	set(val):
		shape = val
		if collision_shape:
			collision_shape.shape = val

@export var curve: Curve2D:
	set(val):
		curve = val
		if path:
			path.curve = val
	
