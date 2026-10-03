class_name TrafficLight
extends TextureRect

const tex_red: Texture2D = preload("res://assets/traffic-light-red.svg")
const tex_green: Texture2D = preload("res://assets/traffic-light-green.svg")

func make_red() -> void:
	texture = tex_red

func make_green() -> void:
	texture = tex_green
