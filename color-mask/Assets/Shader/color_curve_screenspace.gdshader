shader_type canvas_item;


uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
// Color filters - enable/disable individual color ranges
uniform bool show_reds = true;
uniform bool show_oranges = true;
uniform bool show_yellows = true;
uniform bool show_greens = true;
uniform bool show_cyans = true;
uniform bool show_blues = true;
uniform bool show_magentas = true;

// Saturation controls for each color (0.0 = grayscale, 1.0 = full color)
uniform float red_saturation : hint_range(0.0, 1.0) = 1.0;
uniform float orange_saturation : hint_range(0.0, 1.0) = 1.0;
uniform float yellow_saturation : hint_range(0.0, 1.0) = 1.0;
uniform float green_saturation : hint_range(0.0, 1.0) = 1.0;
uniform float cyan_saturation : hint_range(0.0, 1.0) = 1.0;
uniform float blue_saturation : hint_range(0.0, 1.0) = 1.0;
uniform float magenta_saturation : hint_range(0.0, 1.0) = 1.0;

// Fine-tune the color ranges (in HSV hue space, 0.0 - 1.0)
uniform float red_hue_center = 0.0; // 0° - Red
uniform float orange_hue_center = 0.083; // 30° - Orange
uniform float yellow_hue_center = 0.167; // 60° - Yellow
uniform float green_hue_center = 0.333; // 120° - Green
uniform float cyan_hue_center = 0.5; // 180° - Cyan
uniform float blue_hue_center = 0.667; // 240° - Blue
uniform float magenta_hue_center = 0.833; // 300° - Magenta

uniform float hue_range : hint_range(0.01, 0.2) = 0.083; // How wide each color range is

vec3 rgb2hsv(vec3 c) {
	vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
	vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
	vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
	float d = q.x - min(q.w, q.y);
	float e = 1.0e-10;
	return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 hsv2rgb(vec3 c) {
	vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
	vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
	return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

bool is_in_hue_range(float hue, float center, float range) {
	float diff = abs(hue - center);
	// Handle wraparound at red (0.0/1.0)
	if (diff > 0.5) {
		diff = 1.0 - diff;
	}
	return diff < range;
}

void fragment() {
	vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV);
	vec3 hsv = rgb2hsv(color.rgb);
	
	float saturation_multiplier = 0.0; // Default to grayscale
	
	// Check if pixel matches any enabled color range
	if (show_reds && is_in_hue_range(hsv.x, red_hue_center, hue_range)) {
		saturation_multiplier = red_saturation;
	}
	else if (show_oranges && is_in_hue_range(hsv.x, orange_hue_center, hue_range)) {
		saturation_multiplier = orange_saturation;
	}
	else if (show_yellows && is_in_hue_range(hsv.x, yellow_hue_center, hue_range)) {
		saturation_multiplier = yellow_saturation;
	}
	else if (show_greens && is_in_hue_range(hsv.x, green_hue_center, hue_range)) {
		saturation_multiplier = green_saturation;
	}
	else if (show_cyans && is_in_hue_range(hsv.x, cyan_hue_center, hue_range)) {
		saturation_multiplier = cyan_saturation;
	}
	else if (show_blues && is_in_hue_range(hsv.x, blue_hue_center, hue_range)) {
		saturation_multiplier = blue_saturation;
	}
	else if (show_magentas && is_in_hue_range(hsv.x, magenta_hue_center, hue_range)) {
		saturation_multiplier = magenta_saturation;
	}
	
	// Apply saturation multiplier
	hsv.y *= saturation_multiplier;
	COLOR = vec4(hsv2rgb(hsv), color.a);
}