shader_type canvas_item;

uniform float speed : hint_range(-10, 10) = 1;
uniform vec4 fill_color : hint_color = vec4(0.92, 0.9, 0.88, 1);
uniform float sprite_fade : hint_range(0.0, 1.0) = 1.0;


vec4 tint_color(vec4 txt, vec4 color)
{
	txt.rgb = mix(txt.rgb, color.rgb, color.a);
	return txt;
}

float mark_light(vec2 uv, float _speed, float _time)
{
	vec2 co = uv * 5.0;
	float v = _time * _speed;
	float n = sin(v + co.x) + sin(v - co.x) + sin(v + co.y) + sin(v + 2.5 * co.y);
	return fract((5.0 + n) / 5.0);
}


vec4 transform_ghost(vec2 uv, sampler2D txt, float _speed, float time)
{
	vec4 txt_color = texture(txt, uv);
	
	float n = mark_light(uv, _speed, time);
	n += dot(txt_color.rbg, vec3(0.6, 0.4, 0.2));
	n = fract(n);
	
	float a = clamp(abs(n * 6.0 - 2.0), 0.0, 1.0);
	return vec4(vec3(1. - a), a * a * txt_color.a);
}


void fragment()
{
	vec4 transform_ghost = transform_ghost(UV, TEXTURE, speed, TIME);
	vec4 color = tint_color(transform_ghost, fill_color);
	vec4 output_color = color;

	output_color.a *= sprite_fade;
	COLOR = output_color;
}
