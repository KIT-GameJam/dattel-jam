shader_type canvas_item;

const vec3 WHITE = vec3(.3);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 uv = UV * vec2(SCREEN_PIXEL_SIZE.y / SCREEN_PIXEL_SIZE.x, 1.0) * 2.0;
	uv.y += sin(uv.x * 3.) * .1;
	uv.y += sin(uv.x * 2. + TIME * 2.0) * .02;
	vec2 inrect = fract(uv + TIME * 0.1);
	bool isr = inrect.x >= .5;
	bool isd = inrect.y >= .5;
	if ((isr && isd) || (!isr && !isd)) COLOR = vec4(WHITE,1.);
	else COLOR = vec4(0.,0.,0.,1.);
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
