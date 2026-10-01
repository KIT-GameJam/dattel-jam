@tool
extends RichTextEffect
class_name JumpingLettersEffect

const bbcode = "jumping_letters"
var button: Button = null
var label: RichTextLabel = null
var active := true

const EFFECT_SCALE := 0.8
const JUMP_TIME_OFFSET := 0.65
const JUMP_FACTOR := 0.3 * EFFECT_SCALE
const SQUEEZE_TOFF := 0.35
const SQUEEZE_FREQ := 3.0
const SQUEEZE_AMNT := 0.6 * EFFECT_SCALE
const IDLE := 0.8
const TIME_SCALE := 2.0
const WAVE_FREQ := 0.014

func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	if not active or button == null or label == null:
		return false
	var roff := char_fx.transform.get_origin()
	var t: float = fposmod(char_fx.elapsed_time * TIME_SCALE - roff.x * WAVE_FREQ, 1.0 + IDLE)
	if t >= 1.0:
		return false

	var text_server := TextServerManager.get_primary_interface()
	var baseline := text_server.font_get_ascent(char_fx.font, label.get_theme_font_size("normal_font_size"))

	var squeeze_t: float = abs(t - SQUEEZE_TOFF) * SQUEEZE_FREQ
	var change := false
	if squeeze_t < 1.0:
		var squeeze: float = 1.0 - (1.0 - squeeze_t) * SQUEEZE_AMNT
		var boff: float = roff.y
		char_fx.transform = char_fx.transform.translated(Vector2(0.0, -boff))
		char_fx.transform = char_fx.transform.scaled(Vector2(1.0, squeeze))
		char_fx.transform = char_fx.transform.translated(Vector2(0.0, boff))
		change = true

	if t > JUMP_TIME_OFFSET:
		var jt := (t - JUMP_TIME_OFFSET) / (1.0 - JUMP_TIME_OFFSET)
		var jump: float = sin(jt * PI) * baseline * JUMP_FACTOR
		char_fx.offset.y -= jump
		change = true

	return change
