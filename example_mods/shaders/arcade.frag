#pragma header
vec2 uv = openfl_TextureCoordv.xy;
vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;
uniform float iTime;
#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main

float curvature = 0.5;
float powa = 2.5;

vec2 curve(vec2 inp)
{
    inp.y += (inp.y - .5) * curvature * pow(abs(inp.x - .5), powa);
    inp.x += (inp.x - .5) * curvature * pow(abs(inp.y - .5), powa);
    return inp;
}

void main()
{
    vec2 uv = curve(fragCoord/iResolution.xy);
    fragColor = (abs(uv.x - .5) > .5 || abs(uv.y - .5) > .5? 0. : 1.) * texture(iChannel0, uv);
}
