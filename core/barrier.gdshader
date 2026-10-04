shader_type canvas_item;

void fragment() {
	vec2 uv = UV * 20. + TIME * .8;
	ivec2 iuv = ivec2(uv);
	if (((iuv.x ^ iuv.y) & 1) != 0)
		COLOR = texture(TEXTURE, uv);
	else COLOR = vec4(0.);
	COLOR.a *= 1. - distance(UV, vec2(.5, 1.)) * 3.;
}