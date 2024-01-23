//SHADERTOY PORT FIX
#pragma header
vec2 uv = openfl_TextureCoordv.xy;
vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;
uniform float iTime;
#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main
//****MAKE SURE TO remove the parameters from mainImage.
//SHADERTOY PORT FIX


void mainImage(void)
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;
    
    float depth = 5.0f;

	float dx = distance(uv.x, .5f);
    float dy = distance(uv.y, .5f);
    
    
    float offset = (dx*.2) * dy;
    
    float dir = 0.;
    if (uv.y <= .5) 
        dir = 1.0;
    else
        dir = -1.;
    
    vec2 coords = vec2(uv.x, uv.y + dx*(offset*depth*dir));
    
    vec2 nuv = coords;
    //vec2 nuv = coords + vec2(iMouse.x/mouse_speed_divisor,0.);
    
    fragColor = texture(iChannel0, nuv); 
}
