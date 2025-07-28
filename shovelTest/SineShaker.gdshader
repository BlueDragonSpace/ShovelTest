//shifts on axis according to a sine wave
shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

// of the equation y = a * sin(bx - h) + k
uniform float period_width : hint_range(0,10) = 1.0; // aka "a" (speeds up with time)
uniform float amplitude : hint_range(0,1) = 0.1; //aka "b"

uniform float shake_speed : hint_range(0,1) = 0.125; // very close to being "a" (doesn't speed up with time)
//shake_speed also modifies period_width...
//I'd reccomend period_width if you want it to shake faster, shake_speed for shaking slower

uniform bool pixel = true;
uniform bool y_axis = true;
uniform bool tangent = false;

void fragment() {

	vec3 newColor = textureLod(screen_texture, SCREEN_UV, 0.0).rgb;

	//yeah I know it's a bunch of copy pasted sections with very little changes to each section and it should be object-oriented or whatever
	// point is it works, and I'm happy with it
	// processing times be damned lol

	if (tangent){
		if (y_axis)
			if (pixel) {
				COLOR = texture(screen_texture, UV + vec2( tan(period_width * (TIME + shake_speed * floor(UV.y / float(TEXTURE_PIXEL_SIZE.y) ) ) ) * amplitude, 0));
			}
			else {
				COLOR = texture(screen_texture, UV + vec2( tan(period_width * (TIME + shake_speed * UV.y) ) * amplitude, 0));
			}
		else{
			if (pixel) {
				COLOR = texture(screen_texture, UV + vec2(0, tan(period_width * (TIME + shake_speed * floor(UV.x / float(TEXTURE_PIXEL_SIZE.x) ) ) ) * amplitude));
			}
			else {
				COLOR = texture(screen_texture, UV + vec2(0, tan(period_width * (TIME + shake_speed * UV.x) ) * amplitude));
			}
		}
	}
	else{
		if (y_axis)
			if (pixel) {
				COLOR = texture(screen_texture, UV + vec2( sin(period_width * (TIME + shake_speed * floor(UV.y / float(TEXTURE_PIXEL_SIZE.y) ) ) ) * amplitude, 0));
			}
			else {
				COLOR = texture(screen_texture, UV + vec2( sin(period_width * (TIME + shake_speed * UV.y) ) * amplitude, 0));
			}
		else{
			if (pixel) {
				COLOR = texture(screen_texture, UV + vec2(0, sin(period_width * (TIME + shake_speed * floor(UV.x / float(TEXTURE_PIXEL_SIZE.x) ) ) ) * amplitude));
			}
			else {
				COLOR = texture(screen_texture, UV + vec2(0, sin(period_width * (TIME + shake_speed * UV.x) ) * amplitude));
			}
		}
	}
}
