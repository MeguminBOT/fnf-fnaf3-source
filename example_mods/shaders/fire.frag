// Optimized the shader
// Lulu

#pragma header

#define round(a) floor(a + 0.5)
#define iResolution vec3(openfl_TextureSize, 0.)
uniform float iTime;
#define iChannel0 bitmap
#define texture flixel_texture2D

vec4 flixel_texture2D(sampler2D bitmap, vec2 coord, float bias) {
    vec4 color = texture2D(bitmap, coord, bias);
    if (color.a == 0.0) {
        return vec4(0.0, 0.0, 0.0, 0.0);
    }
    color.rgb /= color.a;
    mat4 colorMultiplier = mat4(0);
    colorMultiplier[0][0] = openfl_ColorMultiplierv.x;
    colorMultiplier[1][1] = openfl_ColorMultiplierv.y;
    colorMultiplier[2][2] = openfl_ColorMultiplierv.z;
    colorMultiplier[3][3] = openfl_ColorMultiplierv.w;
    color = clamp(openfl_ColorOffsetv + (color * colorMultiplier), 0.0, 1.0);
    if (color.a > 0.0) {
        return vec4(color.rgb * color.a, color.a);
    }
    return vec4(0.0, 0.0, 0.0, 0.0);
}

vec3 rgb2hsv(vec3 c) {
    float minComponent = min(min(c.r, c.g), c.b);
    float maxComponent = max(max(c.r, c.g), c.b);
    float delta = maxComponent - minComponent;
    
    float h = 0.0;
    float s = (maxComponent > 0.0) ? delta / maxComponent : 0.0;
    float v = maxComponent;
    
    if (delta > 0.0) {
        if (maxComponent == c.r) {
            h = (c.g - c.b) / delta;
            if (h < 0.0) {
                h += 6.0;
            }
        } else if (maxComponent == c.g) {
            h = 2.0 + (c.b - c.r) / delta;
        } else {
            h = 4.0 + (c.r - c.g) / delta;
        }
        h /= 6.0;
    }
    
    return vec3(h, s, v);
}

vec3 hsv2rgb(vec3 c) {
    vec3 rgb = clamp(abs(mod(c.x * 6.0 + vec3(0.0, 4.0, 2.0), 6.0) - 3.0) - 1.0, 0.0, 1.0);
    rgb = rgb * rgb * (3.0 - 2.0 * rgb); // Apply smoothstep function
    return c.z * mix(vec3(1.0), rgb, c.y);
}


float rand(vec2 n) {
    return fract(sin(dot(n, vec2(12.9898, 78.233))) * 43758.5453);
}

float noise(vec2 n) {
    const vec2 d = vec2(0.0, 1.0);
    vec2 b = floor(n);
    vec2 f = fract(n);
    
    vec2 u = f * f * (3.0 - 2.0 * f); // Faster approximation of smoothstep
    
    vec4 r = vec4(rand(b), rand(b + d.yx), rand(b + d.xy), rand(b + d.yy));
    
    return mix(
        mix(r.x, r.y, u.x),
        mix(r.z, r.w, u.x),
        u.y
    );
}

float fbm(vec2 n) {
    float total = 0.0, amplitude = 1.0;
    float persistence = 0.47;
    for (int i = 0; i < 5; i++) {
        total += noise(n) * amplitude;
        n *= 1.7;
        amplitude *= persistence;
    }
    return total;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    const vec3 c1 = vec3(0.5, 0.0, 0.1);
    const vec3 c2 = vec3(0.9, 0.1, 0.0);
    const vec3 c3 = vec3(0.2, 0.1, 0.7);
    const vec3 c4 = vec3(1.0, 0.9, 0.1);

    vec2 speed = vec2(1.2, 0.1);
    float shift = 1.327 + sin(iTime * 2.0) / 2.4;
    float alpha = 2.1;

    float dist = 3.5 - sin(iTime * 0.4) / 1.89;

    vec2 p = fragCoord.xy * dist / iResolution.xx;
    float timeOffset = iTime / 1.1;
    p.x -= timeOffset;
    
    float sinTime = sin(iTime);
    float cosTime = cos(iTime);
    vec2 q = vec2(
        fbm(p - timeOffset * 0.01 + 1.0 * sinTime / 10.0),
        fbm(p - timeOffset * 0.002 + 0.1 * cosTime / 5.0)
    );
    vec2 r = vec2(
        fbm(p + q / 2.0 + timeOffset * speed.x - p.x - p.y),
        fbm(p + q - timeOffset * speed.y)
    );
    
    vec3 c = mix(c1, c2, fbm(p + r)) + mix(c3, c4, r.x);
    vec3 color = vec3(c * cos(shift * fragCoord.y / iResolution.y));
    color += 0.05;
    color.r *= 0.8;
    
    vec3 hsv = rgb2hsv(color);
    hsv.y *= hsv.z * 1.1;
    hsv.z *= hsv.y * 1.13;
    hsv.y = (2.2 - hsv.z * 0.9) * 1.20;
    color = hsv2rgb(hsv);
    
    vec4 camColor = texture(iChannel0, fragCoord.xy / iResolution.xy);
    fragColor = camColor + vec4(color.x, color.y, color.z, alpha) * 0.2;
}

void main() {
    mainImage(gl_FragColor, openfl_TextureCoordv * openfl_TextureSize);
}