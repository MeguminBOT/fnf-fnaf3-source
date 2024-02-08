#pragma header

uniform sampler2D iChannel0;
uniform vec2 iResolution;

float SCurve(float value, float amount, float correction) {
    float curve = 1.0;

    if (value < 0.5) {
        curve = smoothstep(0.0, 1.0, pow(value * 2.0, amount));
    } else {
        curve = 1.0 - smoothstep(0.0, 1.0, pow((1.0 - value) * 2.0, amount));
    }

    return pow(curve, correction);
}

vec3 chromaticAbberation(vec2 uv, float amount) {
    float aberrationAmount = amount / 10.0;
    vec2 distFromCenter = uv - 0.5;
    vec2 aberrated = aberrationAmount * pow(distFromCenter, vec2(3.0));

    vec3 color = vec3(0.0);

    for (int i = 1; i <= 8; i++) {
        float weight = 1.0 / pow(2.0, float(i));
        color.r += texture(iChannel0, uv - float(i) * aberrated).r * weight;
        color.b += texture(iChannel0, uv + float(i) * aberrated).b * weight;
    }

    color.g = texture(iChannel0, uv).g * 0.9961;

    return color;
}

vec3 flares(vec2 uv, float threshold, float intensity, float stretch, float brightness) {
    threshold = 1.0 - threshold;

    vec3 hdr = texture(iChannel0, uv).rgb;
    hdr = vec3(floor(threshold + pow(hdr.r, 1.0)));

    float d = intensity;
    float c = intensity * stretch;

    float iChannel0L = texture(iChannel0, uv + vec2(c / d, 0.0)).r;
    float iChannel0R = texture(iChannel0, uv - vec2(c / d, 0.0)).r;
    hdr += floor(threshold + pow(max(iChannel0L, iChannel0R), 4.0)) * (1.0 - c / d);

    for (float i = c / 2.0; i > -1.0; i--) {
        float iChannel0U = texture(iChannel0, uv + vec2(0.0, i / d)).r;
        float iChannel0D = texture(iChannel0, uv - vec2(0.0, i / d)).r;
        hdr += floor(threshold + pow(max(iChannel0U, iChannel0D), 40.0)) * (1.0 - i / c) * 0.25;
    }

    hdr *= vec3(0.5, 0.4, 1.0);

    return hdr * brightness;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord.xy / iResolution.xy;
    vec3 color = texture(iChannel0, uv).xyz;

    color = chromaticAbberation(uv, 0.8);
    color *= vec3(0.9 + randomFloat() * 0.15);
    color = ACESFilm(color) * 0.9;
    color += flares(uv, 0.9, 200.0, 0.5, 0.06);

    fragColor = vec4(color, texture(iChannel0, uv).a);
}

void main() {
    mainImage(gl_FragColor, openfl_TextureCoordv * openfl_TextureSize);
}
