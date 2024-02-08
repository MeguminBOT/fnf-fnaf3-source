#pragma header
#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main

float curvature = 0.5;
float powa = 2.5;

void main()
{
    vec2 fragCoord = openfl_TextureCoordv * openfl_TextureSize;
    vec2 uv = (fragCoord / openfl_TextureSize) + (fragCoord - 0.5) * curvature * pow(abs(fragCoord - 0.5), powa);
    fragColor = step(0.5, abs(uv.x - 0.5)) * step(0.5, abs(uv.y - 0.5)) * texture(iChannel0, uv);
}
