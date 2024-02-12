// Optimized the shader
// Lulu
#pragma header

#define iResolution vec3(openfl_TextureSize, 0.)
#define iChannel0 bitmap
uniform sampler2D iChannel1;
uniform sampler2D iChannel2;
uniform sampler2D iChannel3;
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

const int size = 5;
const float hacky = 4.;
const float divider = 1. / 20.;

float brightnessFunction(in float number) {
    float eee = exp(16. * number - 1.);
    return 2. * eee / (2. + (eee - 1.));
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 multi = 1. / iResolution.xy;
    vec4 addition, tempColor;
    float tlength = float(size) * float(size);
    vec4 number = texture(iChannel0, fragCoord * multi);
    for (float i = -float(size) * hacky; i < float(size) * hacky; i += hacky) {
        for (float j = -float(size) * hacky; j < float(size) * hacky; j += hacky) {
            tempColor = texture(iChannel0, multi * (fragCoord + vec2(i, j)));
            float theLength = tempColor.x * tempColor.x + tempColor.y * tempColor.y + tempColor.z * tempColor.z;
            if (theLength > brightness) {
                tlength = (float(size) - length(vec2(i, j))) / float(size);
                addition = tempColor;
                if (tlength > 0.) {
                    number += tempColor * tlength * divider;
                }
            }
        }
    }
    vec4 outputColor = texture(iChannel0, fragCoord * multi);
    if (number.w > 0. && iMouse.x < fragCoord.x) {
        outputColor = number / number.w;
    }
    fragColor = outputColor;
}

void main() {
    mainImage(gl_FragColor, openfl_TextureCoordv * openfl_TextureSize);
}