uniform float iTime;
uniform sampler2D iChannel1;
uniform sampler2D iChannel2;
uniform sampler2D iChannel3;
uniform vec3 iResolution;

vec4 flixel_texture2D(sampler2D bitmap, vec2 coord, float bias) {
    vec4 color = texture2D(bitmap, coord, bias);
    return color * openfl_Alphav;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    const vec3 c1 = vec3(0.5, 0.0, 0.1);
    const vec3 c2 = vec3(0.9, 0.1, 0.0);
    const vec3 c3 = vec3(0.2, 0.1, 0.7);
    const vec3 c4 = vec3(1.0, 0.9, 0.1);
    const vec3 c5 = vec3(0.1);
    const vec3 c6 = vec3(0.9);

    vec2 speed = vec2(1.2, 0.1);
    float shift = 1.327 + sin(iTime * 2.0) / 2.4;
    float alpha = 2.1;

    float dist = 3.5 - sin(iTime * 0.4) / 1.89;

    vec2 p = fragCoord.xy * dist / iResolution.xx;
    p.x -= iTime / 1.1;
    float q = fbm(p - iTime * 0.01 + 1.0 * sin(iTime) / 10.0);
    float qb = fbm(p - iTime * 0.002 + 0.1 * cos(iTime) / 5.0);
    float q2 = fbm(p - iTime * 0.44 - 5.0 * cos(iTime) / 7.0) - 6.0;
    float q3 = fbm(p - iTime * 0.9 - 10.0 * cos(iTime) / 30.0) - 4.0;
    float q4 = fbm(p - iTime * 2.0 - 20.0 * sin(iTime) / 20.0) + 2.0;
    q = (q + qb - 0.4 * q2 - 2.0 * q3 + 0.6 * q4) / 3.8;
    vec2 r = vec2(fbm(p + q / 2.0 + iTime * speed.x - p.x - p.y), fbm(p + q - iTime * speed.y));
    vec3 c = mix(c1, c2, fbm(p + r)) + mix(c3, c4, r.x) - mix(c5, c6, r.y);
    vec3 color = vec3(c * cos(shift * fragCoord.y / iResolution.y));
    color += vec3(0.05);
    color.r *= 0.8;
    vec3 hsv = rgb2hsv(color);
    hsv.y *= hsv.z * 1.1;
    hsv.z *= hsv.y * 1.13;
    hsv.y = (2.2 - hsv.z * 0.9) * 1.20;
    color = hsv2rgb(hsv);
    vec4 camColor = texture(iChannel0, fragCoord.xy / iResolution.xy);
    fragColor = camColor * 1.0 + vec4(color.x, color.y, color.z, alpha) * 0.2;
}

void main() {
    mainImage(gl_FragColor, openfl_TextureCoordv * openfl_TextureSize);
}
