class_name Road
extends Node2D

@onready var sprite: Sprite2D = $Sprite
@onready var collision_shape: CollisionPolygon2D = $CollisionPolygon2D
# how fast a car can drive on this ground
@onready var drive_speed := 1.0
