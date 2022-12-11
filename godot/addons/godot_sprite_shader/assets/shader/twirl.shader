shader_type canvas_item;

uniform float center_x : hint_range(0, 1) = 0.5;
uniform float center_y : hint_range(0, 1) = 0.5;
uniform float strength: hint_range(-100, 100) = 20.0;
uniform float offset_x : hint_range(0, 1.0) = 0.0;
uniform float offset_y : hint_range(0, 1.0) = 0.0;

vec2 rotate(vec2 n, float angle)
{
	return mat2(vec2(cos(angle), -sin(angle)), vec2(sin(angle), cos(angle))) * n;
}

vec4 twirl(vec2 uv, sampler2D tex, vec2 center, vec2 offset, float _strength) 
{
	vec2 delta = uv - center;
	float angle = _strength * length(delta);
	vec2 _uv = rotate(delta, angle);
	return texture(tex, _uv + center + offset);
}

void fragment()
{
	vec4 output_color = twirl(UV, TEXTURE, vec2(center_x, center_y), vec2(offset_x, offset_y), strength);
	COLOR = output_color;
}
