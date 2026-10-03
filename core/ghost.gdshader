shader_type canvas_item;

float ssin(float x) { return sin(x) * .5 + .5; }

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 color_shift = vec4(0.7, 0.8, 1.0, 1.0);
	vec2 uv_offset = vec2(0.0, sin(UV.x * 32.0 + TIME * 1.6) * 0.015);
	vec2 uv = UV + uv_offset;
	float afac = ssin(uv.y * 20.0 - TIME * 2.0);
	color_shift.a *= 1. - pow(afac, .6) * .2;
	COLOR = texture(TEXTURE, uv) * color_shift;
	// Called for every pixel the material is visible on.
}
