shader_type canvas_item;

uniform float intensity: hint_range(0, 1) = 1.0;

vec4 sepia(vec2 uv, sampler2D tex, float _intensity) 
{
	vec4 color = texture(tex, uv);
	float r = dot(color.rgb, vec3(0.393, 0.769, 0.189));
	float g = dot(color.rgb, vec3(0.349, 0.686, 0.168));
	float b = dot(color.rgb, vec3(0.272, 0.534, 0.131));
	return mix(color, vec4(r,g,b, color.a), _intensity);
}

void fragment()
{
	vec4 output_color = sepia(UV, TEXTURE, intensity);
	COLOR = output_color;
}
