shader_type canvas_item;

uniform vec4 fade_color = vec4(1, 1, 1, 0);
uniform float fade_intensity = 0;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	color = mix(color, fade_color, fade_intensity * color.a);
	
	COLOR = color;
}