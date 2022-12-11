shader_type canvas_item;

uniform float center_x : hint_range(0, 1) = 0.5;
uniform float center_y : hint_range(0, 1) = 0.5;
uniform float amount: hint_range(1, 60) = 30.0;
uniform float intensity : hint_range(0, 1.0) = 0.0;


vec4 zoom_blur(vec2 uv, sampler2D tex, vec2 center, float _intensity, float _amount) 
{
	_intensity /= _amount;
	vec4 color_zoom_blur = texture(tex, uv);
	
	for (float i = 0.0; i < _amount; i++) {
		float d = _intensity * float(i);
		vec2 _uv = uv * (1.0 - d) + center * d;
		color_zoom_blur += texture(tex, _uv);
	}
	color_zoom_blur /= float(_amount + 1.);
	return color_zoom_blur;
}

void fragment()
{
	vec4 output_color = zoom_blur(UV, TEXTURE, vec2(center_x, center_y), intensity, amount);
	COLOR = output_color;
}
