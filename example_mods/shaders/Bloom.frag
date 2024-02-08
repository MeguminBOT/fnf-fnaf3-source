#pragma header

uniform sampler2D iChannel0;
uniform vec2 iResolution;
uniform vec4 iMouse;

const int size = 5;
const float hacky = 4.0;
const float divider = 1.0 / 20.0;
const float brightness = 1.0;

float brightnessFunction(in float number) {
    float eee = exp(16.0 * number - 1.0);
    return 2.0 * eee / (2.0 + (eee - 1.0));
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 multi = 1.0 / iResolution.xy;
    vec4 addition, tempColor;
    float tlength = float(size) * float(size);
    vec4 number = texture(iChannel0, fragCoord * multi);

    for (float i = -float(size) * hacky; i < float(size) * hacky; i += hacky) {
        for (float j = -float(size) * hacky; j < float(size) * hacky; j += hacky) {
            vec2 offset = vec2(i, j) * multi;
            tempColor = texture(iChannel0, fragCoord + offset);
            float theLength = dot(tempColor.xyz, tempColor.xyz);
            float normalizedDistance = (float(size) - length(vec2(i, j))) / float(size);

            if (theLength > brightness && normalizedDistance > 0.0) {
                number += tempColor * normalizedDistance * divider;
            }
        }
    }

    vec4 outputColor = texture(iChannel0, fragCoord * multi);
    if (number.w > 0.0 && iMouse.x < fragCoord.x) {
        outputColor = number / number.w;
    }

    fragColor = outputColor;
}

void main() {
    mainImage(gl_FragColor, openfl_TextureCoordv * openfl_TextureSize);
}
