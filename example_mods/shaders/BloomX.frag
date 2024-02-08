#pragma header

uniform sampler2D iChannel0;
uniform vec2 iResolution;

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
	vec2 uv = fragCoord / iResolution.xy;
	fragColor = texture(iChannel0, uv);

	const float range = 0.1; // Length of glow streaks
	const float steps = 0.005; // Number of texture samples / 2
	const float threshold = 0.6; // Color key threshold (0-1)
	const float brightness = 5.0; // Glow brightness

	for (float i = -range; i < range; i += steps) {
		float falloff = 1.0 - abs(i / range);
		vec2 offset = vec2(i, -i);

		vec4 blur = texture(iChannel0, uv + offset);
		if (blur.r + blur.g + blur.b > threshold * 3.0) {
			fragColor += blur * falloff * steps * brightness;
		}
	}
}

void main() {
	mainImage(gl_FragColor, openfl_TextureCoordv * openfl_TextureSize);
}
