@tool
class_name Road
extends Node2D

@onready var sprite: Sprite2D = $Sprite

@onready var collision_shape: CollisionShape2D = $CollisionShape2D 

@export var texture: Texture2D:
	set(val):
		texture = val
		sprite.texture = val
		
@export var shape: Shape2D:
	set(val):
		shape = val
		collision_shape.shape = val
