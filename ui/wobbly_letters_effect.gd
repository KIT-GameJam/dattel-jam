@tool
class_name WobblyLettersEffect
extends RichTextEffect

const bbcode = "wobbly_letters"

func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	var xoff: float = char_fx.transform.origin.x * 0.3
	char_fx.offset.x = cos(char_fx.elapsed_time * 1.6 + xoff) * 1.6
	char_fx.offset.y = sin(char_fx.elapsed_time * 2.0 + xoff) * 1.6
	char_fx.transform = char_fx.transform.rotated_local(sin(char_fx.elapsed_time * 1.4 + xoff) * 0.04)
	return true
