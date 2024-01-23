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

#define Strength 0.003f
#define Speed 0.6f

#define NoiseTiling 8.0f
#define NoiseSpeed 0.5f

#define PulseSpeed 2.0f
#define PulseMin 1.0f
#define PulseMax 2.0f

#define M_PI 3.1415926535897932384626433832795

//===============================================================================================
// IQ GRADIENT NOISE FROM HERE: https://www.shadertoy.com/view/4dffRH
//===============================================================================================
vec3 hash( vec3 p ) // replace this by something better. really. do
{
	p = vec3( dot(p,vec3(127.1,311.7, 74.7)),
			  dot(p,vec3(269.5,183.3,246.1)),
			  dot(p,vec3(113.5,271.9,124.6)));

	return -1.0 + 2.0*fract(sin(p)*43758.5453123);
}

// return value noise (in x) and its derivatives (in yzw)
vec4 noised( in vec3 x )
{
    // grid
    vec3 i = floor(x);
    vec3 w = fract(x);
    
    #if 1
    // quintic interpolant
    vec3 u = w*w*w*(w*(w*6.0-15.0)+10.0);
    vec3 du = 30.0*w*w*(w*(w-2.0)+1.0);
    #else
    // cubic interpolant
    vec3 u = w*w*(3.0-2.0*w);
    vec3 du = 6.0*w*(1.0-w);
    #endif    
    
    // gradients
    vec3 ga = hash( i+vec3(0.0,0.0,0.0) );
    vec3 gb = hash( i+vec3(1.0,0.0,0.0) );
    vec3 gc = hash( i+vec3(0.0,1.0,0.0) );
    vec3 gd = hash( i+vec3(1.0,1.0,0.0) );
    vec3 ge = hash( i+vec3(0.0,0.0,1.0) );
	vec3 gf = hash( i+vec3(1.0,0.0,1.0) );
    vec3 gg = hash( i+vec3(0.0,1.0,1.0) );
    vec3 gh = hash( i+vec3(1.0,1.0,1.0) );
    
    // projections
    float va = dot( ga, w-vec3(0.0,0.0,0.0) );
    float vb = dot( gb, w-vec3(1.0,0.0,0.0) );
    float vc = dot( gc, w-vec3(0.0,1.0,0.0) );
    float vd = dot( gd, w-vec3(1.0,1.0,0.0) );
    float ve = dot( ge, w-vec3(0.0,0.0,1.0) );
    float vf = dot( gf, w-vec3(1.0,0.0,1.0) );
    float vg = dot( gg, w-vec3(0.0,1.0,1.0) );
    float vh = dot( gh, w-vec3(1.0,1.0,1.0) );
	
    // interpolations
    return vec4( va + u.x*(vb-va) + u.y*(vc-va) + u.z*(ve-va) + u.x*u.y*(va-vb-vc+vd) + u.y*u.z*(va-vc-ve+vg) + u.z*u.x*(va-vb-ve+vf) + (-va+vb+vc-vd+ve-vf-vg+vh)*u.x*u.y*u.z,    // value
                 ga + u.x*(gb-ga) + u.y*(gc-ga) + u.z*(ge-ga) + u.x*u.y*(ga-gb-gc+gd) + u.y*u.z*(ga-gc-ge+gg) + u.z*u.x*(ga-gb-ge+gf) + (-ga+gb+gc-gd+ge-gf-gg+gh)*u.x*u.y*u.z +   // derivatives
                 du * (vec3(vb,vc,ve) - va + u.yzx*vec3(va-vb-vc+vd,va-vc-ve+vg,va-vb-ve+vf) + u.zxy*vec3(va-vb-ve+vf,va-vb-vc+vd,va-vc-ve+vg) + u.yzx*u.zxy*(-va+vb+vc-vd+ve-vf-vg+vh) ));
}
//===============================================================================================

vec2 Rotate2dVector(vec2 v, vec2 a) {
	return vec2(a.x*v.x - a.y*v.y, a.y*v.x + a.x*v.y);
}

float Pulse(float t, float noise) {
    float p = (sin(t * PulseSpeed)+1.)/2.;
    return (p * (PulseMax - PulseMin) + PulseMin) * noise;
}

vec2 GetVector(vec2 v, float rad, float noise) {
    vec2 angle = vec2(cos(rad),sin(rad)); // how much to rotate vector, rotate as a circle
    angle *= Pulse(rad, noise); // scale the vector by time (this makes a "flower" pattern)
    vec2 v_rot = Rotate2dVector(v, angle);
    return v_rot;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    // define the UVs, make them square by using the same iRes dimension
	vec2 uv = fragCoord.xy/iResolution.xy;
    
    float mixer = 1.;
    //mixer = 1.-smoothstep(0.,1., (sin(iTime)+2.)/2.-1.)*2.; // uncomment this to animate the effect
    float shift_amount = mixer * Strength;
    
    // rotate the angle of each channel by this amount [radians]
    // since there are 3 channels, the vector should be rotated 120 degrees per channel eg. 0,120,240
    float div = M_PI * 2. / 3.;
    float t = iTime * Speed;
    float i = mod(div + (t*2.), M_PI*2.0);
    float j = mod((div * 2.) + (t*2.), M_PI*2.0);
    float k = mod((div * 3.) + (t*2.), M_PI*2.0);
    
   	vec2 vec = vec2(1.,0.); // initial vector, this is to be rotated like the dial of a clock

    // generate some noise to scale vector
    vec2 p = (-iResolution.xy + 2.0*fragCoord) / iResolution.y * NoiseTiling;
    vec4 n = noised(vec3(p.x, p.y, iTime * NoiseSpeed));
    n.x = (n.x + 1.) / 2.; // normalize 0-1
    //n.x = pow(n.x, 1.5);

    vec2 v_r = GetVector(vec, i, n.x);
    vec2 v_g = GetVector(vec, j, n.x);
    vec2 v_b = GetVector(vec, k, n.x);

    vec2 r_shift = v_r * shift_amount;
    vec2 g_shift = v_g * shift_amount;
    vec2 b_shift = v_b * shift_amount;
	
    vec3 clr;
    clr.r = texture(iChannel0, uv + vec2(r_shift.x, r_shift.y)).r;
    clr.g = texture(iChannel0, uv + vec2(g_shift.x, g_shift.y)).g;
   	clr.b = texture(iChannel0, uv + vec2(b_shift.x, b_shift.y)).b;
    
    fragColor = vec4(clr,texture(iChannel0, uv).a);   
}

void main() {
	mainImage(gl_FragColor, openfl_TextureCoordv*openfl_TextureSize);
}