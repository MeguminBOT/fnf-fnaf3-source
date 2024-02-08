// Automatically converted with https://github.com/TheLeerName/ShadertoyToFlixel

#pragma header

#define round(a) floor(a + 0.5)
#define iResolution vec3(openfl_TextureSize, 0.)
uniform float iTime;
#define iChannel0 bitmap
uniform sampler2D iChannel1;
uniform sampler2D iChannel2;
uniform sampler2D iChannel3;
#define texture flixel_texture2D

// third argument fix
vec4 flixel_texture2D(sampler2D bitmap, vec2 coord, float bias) {
	vec4 color = texture2D(bitmap, coord, bias);
	if (!hasTransform)
	{
		return color;
	}
	if (color.a == 0.0)
	{
		return vec4(0.0, 0.0, 0.0, 0.0);
	}
	if (!hasColorTransform)
	{
		return color * openfl_Alphav;
	}
	color = vec4(color.rgb / color.a, color.a);
	mat4 colorMultiplier = mat4(0);
	colorMultiplier[0][0] = openfl_ColorMultiplierv.x;
	colorMultiplier[1][1] = openfl_ColorMultiplierv.y;
	colorMultiplier[2][2] = openfl_ColorMultiplierv.z;
	colorMultiplier[3][3] = openfl_ColorMultiplierv.w;
	color = clamp(openfl_ColorOffsetv + (color * colorMultiplier), 0.0, 1.0);
	if (color.a > 0.0)
	{
		return vec4(color.rgb * color.a * openfl_Alphav, color.a * openfl_Alphav);
	}
	return vec4(0.0, 0.0, 0.0, 0.0);
}

// variables which is empty, they need just to avoid crashing shader
uniform float iTimeDelta;
uniform float iFrameRate;
uniform int iFrame;
#define iChannelTime float[4](iTime, 0., 0., 0.)
#define iChannelResolution vec3[4](iResolution, vec3(0.), vec3(0.), vec3(0.))
uniform vec4 iMouse;
uniform vec4 iDate;


//----SETTINGS----------------------
float starg = 0.5;    // Scale target (inverse zoom amount)
float iter = 30.;     // Iterations
float lean = 1.0;     // Skewing value for iteration mixing
float jitter = 0.1;   // Jittering scale
float jspeed = 20.;   // Jittering speed
float glow = 0.2;     // Flare strength
float alpha = 1.0;    // Mix amount
//----------------------------------

float hash (in vec2 uv) {
    vec3 p = vec3(dot(uv.xy,vec2(123.,456.)),dot(uv.xy,vec2(789.,112.)),dot(uv.xy,vec2(345.,678.)));
    return fract(dot(fract(sin(p*10.)*5000.),vec3(987.,654.,321.)));
}

float ease (in float x) {
    return pow(x,2.)*(3.-2.*x);
}

vec2 resize (in vec2 uv, in vec3 p)
{
    vec2 k = vec2(mix(0.,(p.z-1.),p.x),mix(0.,(p.z-1.),p.y));
    return uv*p.z - k;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 focus = vec2(iMouse.xy/iResolution.xy);
    vec2 rtime = vec2(iTime/100.,iTime/100.+1.);
    vec2 jc1 = vec2(hash(floor(rtime.xx*(100.*jspeed))/(100.*jspeed)),
                    hash(floor(rtime.yy*(100.*jspeed))/(100.*jspeed)))*jitter-(jitter/2.);
    vec2 jc2 = vec2(hash(ceil(rtime.xx*(100.*jspeed))/(100.*jspeed)),
                    hash(ceil(rtime.yy*(100.*jspeed))/(100.*jspeed)))*jitter-(jitter/2.);
    vec2 jcenter = mix (jc1,jc2,ease(fract(iTime*jspeed)));
    
    focus += jcenter;
    
    vec2 uv = fragCoord/iResolution.xy;
    vec2 layeruv = uv;    
    vec3 layercol;
    float c, sc, L;
    int layermax = int(ceil(iter+0.001));    
    
    for (int i = 0; i < layermax; i++)
    {
        sc = float(i)/float(layermax);
        L = mix(1.,starg,sc);
        layeruv = resize(uv,vec3(focus,L));
        layercol += mix(vec3(0.),texture(iChannel0,layeruv).rgb*2.,mix(sc,1.-sc,lean));
        c += 1.;
    }
    
    float strength = 1./(1.-glow);
    
    layercol /= c;
    layercol = clamp(layercol*strength-strength/2.,0.,1.);
        
    vec3 col = texture(iChannel0,uv).rgb;
    col += layercol*alpha;
    
    fragColor = vec4(col,texture(iChannel0, uv).a);
}

void main() {
	mainImage(gl_FragColor, openfl_TextureCoordv*openfl_TextureSize);
}