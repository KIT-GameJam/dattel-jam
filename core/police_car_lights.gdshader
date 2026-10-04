shader_type canvas_item;

float get_light(vec2 v, float d, float s) {
	vec2 dir = v / d;
	float angle = dir.y > 0.0 ? acos(dir.x) : -acos(dir.x);
	angle += TIME * s * 4.;
	angle = mod(angle, PI);
	return (angle < 1.) ? pow(1.0 - abs(.5 - angle) * 2., .8) * (.6 - d) * 1.8 : 0.;
}

void fragment() {
	vec2 v = (UV - vec2(.5)) * 2.;
	float d = length(v);
	COLOR = get_light(v, d, 1.) * vec4(0.,0.,1.,1.);
}