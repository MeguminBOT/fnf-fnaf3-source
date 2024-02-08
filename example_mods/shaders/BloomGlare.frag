#pragma header

uniform float iTime;
uniform sampler2D iChannel0;
uniform vec2 iResolution;

float hash(in vec2 p) {
    return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453);
}

float ease(in float x) {
    return smoothstep(0.0, 1.0, x * x * (3.0 - 2.0 * x));
}

vec2 resize(in vec2 uv, in vec3 p) {
    vec2 k = vec2(p.z - 1.0);
    return uv * p.z - k;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 focus = vec2(iMouse.xy / iResolution.xy);
    vec2 rtime = vec2(iTime / 100.0, iTime / 100.0 + 1.0);
    vec2 jc1 = vec2(hash(floor(rtime.xx * 100.0)) / 100.0, hash(floor(rtime.yy * 100.0)) / 100.0) - 0.05;
    vec2 jc2 = vec2(hash(ceil(rtime.xx * 100.0)) / 100.0, hash(ceil(rtime.yy * 100.0)) / 100.0) - 0.05;
    vec2 jcenter = mix(jc1, jc2, ease(fract(iTime * 20.0)));

    focus += jcenter;

    vec2 uv = fragCoord / iResolution.xy;
    vec2 layeruv = uv;
    vec3 layercol;
    float c, sc, L;
    int layermax = 30;

    for (int i = 0; i < layermax; i++) {
        sc = float(i) / float(layermax);
        L = mix(1.0, 0.5, sc);
        layeruv = resize(uv, vec3(focus, L));
        layercol += texture(iChannel0, layeruv).rgb * 2.0 * mix(sc, 1.0 - sc, 1.0);
        c += 1.0;
    }

    float strength = 2.0;

    layercol /= c;
    layercol = clamp(layercol * strength - strength / 2.0, 0.0, 1.0);

    vec3 col = texture(iChannel0, uv).rgb;
    col += layercol;

    fragColor = vec4(col, texture(iChannel0, uv).a);
}

void main() {
    mainImage(gl_FragColor, openfl_TextureCoordv * openfl_TextureSize);
}
