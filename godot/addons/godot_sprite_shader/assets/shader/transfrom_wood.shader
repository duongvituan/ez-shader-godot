shader_type canvas_item;

uniform float intensity : hint_range(0, 1) = 1.0;
uniform float wood_value : hint_range(0, 16) = 3.0;
uniform float dark_value : hint_range(0, 16) = 0.5;

// Converts color to luminance (grayscale)
float luminance(vec3 color)
{
    return dot( color, vec3 (0.22, 0.17, 0.571));
}

// Large base = 1.0, small_base is valid in [0, 1)
float repreat_trapezoid(float x, float small_base) 
{
	x = mod(x, 1.0);
	float k = 1.0 / (1.0 - small_base);
	x *= k;
	float offset = small_base / 2.0;
	float v = min(abs(x-offset), 1.0);
	return v;
}

float mark_light(vec2 uv, float value)
{
	vec2 co = uv * 5.0;
	float n = sin(value + co.x) + sin(value - co.x) + sin(value + co.y) + sin(value + 2.5 * co.y);
	return fract((5.0 + n) / 5.0);
}

float plasma_mark(sampler2D tex, vec2 uv, float value) 
{
	vec4 tex_color = texture(tex, uv);
	float v = mark_light(uv, value * 8.0);
	v *= value;
	v += dot(tex_color.rgb, vec3(11.2, 8.4, 4.2));
	v *= value;
	return repreat_trapezoid(v, 0.6);
}

vec4 transform_wood(vec2 uv, sampler2D tex, float _wood_value, float _intensity, float _dark_value) 
{
	vec2 shift_uv = uv + vec2(0.02, 0.01);
	float wood_mark = plasma_mark(tex, uv, _wood_value) - plasma_mark(tex, shift_uv, _wood_value) * _dark_value;

	vec4 tex_color = texture(tex, uv);
	float lum = luminance(tex_color.rgb);
	lum = clamp(lum * 0.7 + 0.15, 0.333, 0.666);
	vec3 r = vec3(lum - (1.0 - wood_mark) / 8.0);
	r += vec3(0.25, 0.0, -0.15);
	tex_color.rgb = mix(tex_color.rgb, r, vec3(_intensity));
	return tex_color;
}

void fragment()
{
	vec4 transform_wood = transform_wood(UV, TEXTURE, wood_value, intensity, dark_value);
	vec4 output_color = transform_wood;
	COLOR = transform_wood;
}
