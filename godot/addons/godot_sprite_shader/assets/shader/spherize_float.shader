shader_type canvas_item;

uniform float center_x : hint_range(0, 1) = 0.5;
uniform float center_y : hint_range(0, 1) = 0.5;
uniform float strength: hint_range(1, 100) = 20.0;
uniform float offset_x : hint_range(0, 1.0) = 0.0;
uniform float offset_y : hint_range(0, 1.0) = 0.0;


vec4 spherize_float(vec2 uv, sampler2D tex, vec2 center, vec2 offset, float _strength) 
{
	vec2 delte = uv - center;
	float delta2 = dot(delte, delte);
	float delta4 = delta2 * delta2 * delta2;
	vec2 delta_offset = vec2(delta4 * strength);
	return texture(tex, uv + delte * delta_offset + offset);
}

void fragment()
{
	vec4 output_color = spherize_float(UV, TEXTURE, vec2(center_x, center_y), vec2(offset_x, offset_y), strength);
	COLOR = output_color;
}
