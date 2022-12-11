shader_type canvas_item;

uniform float speed : hint_range(0, 10) = 1.0;
uniform float intensity : hint_range(0, 32) = 1.0;


vec4 shake(vec2 uv, sampler2D tex, float time, float _speed, float _intensity) 
{
	time = time * _speed * 0.8;
	uv.x += sin(uv.y + time * 17.5) * 0.01 * _intensity + sin(uv.y + time) * 0.005;
	uv.y += cos(uv.y + time * 17.5) * 0.01 * _intensity + cos(uv.x + time) * 0.005;
	return texture(tex, uv);
}

void fragment()
{
	vec4 output_color = shake(UV, TEXTURE, TIME, speed, intensity);
	COLOR = output_color;
}
