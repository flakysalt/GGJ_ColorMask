shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform bool hide = false;
uniform vec4 color : source_color = vec4(1);
uniform float strength = 0.2;
uniform float saturation : hint_range(0.0, 2.0) = 1.0;

void fragment(){
	vec4 pixel = texture(SCREEN_TEXTURE, SCREEN_UV);
	COLOR = pixel;
	
	if (hide == false){ 
		vec3 grayscale_value = vec3(dot(pixel.rgb, vec3(0.299, 0.587, 0.114)));
		float range = step(distance(pixel.rgb, color.rgb), strength);
		vec3 colored = mix(grayscale_value, pixel.rgb, saturation);
		COLOR.rgb = mix(grayscale_value, colored, range);
	}
}