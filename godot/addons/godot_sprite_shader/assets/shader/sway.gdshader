shader_type canvas_item;

uniform float speed : hint_range(0, 10) = 1.0;
uniform float intensity : hint_range(0, 32) = 0.2;
uniform float offset_y : hint_range(0, 32) = 2.5;


vec4 sway(vec2 uv, sampler2D tex, float _seed, float _speed, float _intensity, float _offset_y) 
{
	float height = uv.y;
	float offset = pow(height, offset_y);
	offset *= (sin(_seed * speed) * _intensity);
	vec2 _uv = clamp(vec2(uv.x + offset, uv.y), vec2(0., 0.), vec2(1., 1.));
	return texture(tex, _uv);
}

void fragment()
{
	vec4 output_color = sway(UV, TEXTURE, TIME, speed, intensity, offset_y);
	COLOR = output_color;
}
