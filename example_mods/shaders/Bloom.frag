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

const int size =5;
const float hacky = 4.;
const float divider = 1./20.;
float modifier(in float number) {
    return 1./number;
}
float rate = 0.1;
float brightnessFunction(in float number) {
    float eee = exp(16.*number - 1.);
    return 2.*eee/(2.+(eee-1.));
        }
//square brightness
const float brightness = 1.;
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 multi = 1./iResolution.xy;
    vec4 addition, tempColor;
    float tlength = float(size)*float(size);
    vec4 number = texture(iChannel0, fragCoord*multi);
    for(float i = -float(size)*hacky; i < float(size)*hacky; i+=hacky) {
        for(float j = -float(size)*hacky; j < float(size)*hacky; j+=hacky) {
            tempColor = texture(iChannel0, multi*(fragCoord+vec2(i, j) ));
            float theLength =  tempColor.x*tempColor.x + tempColor.y*tempColor.y+ tempColor.z*tempColor.z;
            i=i/hacky;
            j=j/hacky;
            if(theLength > brightness/* && float(i)*float(i)+float(j)*float(j) < tlength*/){
                //
				tlength = (float(size)-length(vec2(i,j)))/float(size);
                addition = tempColor;
                //this one is the important bit it is multiplying color by what SHOULD be the normalized distance
                if(tlength>0.) {
                    //tempColor = vec4(0,1,1,1);
            		number += tempColor*tlength*divider;//*brightnessFunction(theLength/4.);
                }
            }
            i=i*hacky;
            j=j*hacky;
        }
    }
    vec4 outputColor = texture(iChannel0, fragCoord*multi);
    if(number.w > 0. && iMouse.x < fragCoord.x) {
        //finish taking average
        outputColor = (number/number.w);
    }
    // Output to screen
    fragColor = outputColor;
}

void main() {
	mainImage(gl_FragColor, openfl_TextureCoordv*openfl_TextureSize);
}