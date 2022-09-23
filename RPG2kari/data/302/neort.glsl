// https://neort.io/art/bnb7t7k3p9f5erb527s0

precision highp float;

uniform vec2 resolution;
uniform float time;
uniform vec2 mouse;
uniform sampler2D backbuffer;

#define PI acos(-1.0)
#define TAU PI*2.0
#define rot(a) mat2(cos(a), sin(a), -sin(a), cos(a))
#define hue(t) (cos((vec3(0,2,-2)/3.0+t)*TAU)*0.5+0.5)

vec2 billboardUv(vec3 ro,vec3 rd, vec3 a)
{
    a-=ro;
    vec3 g= cross(a, rd);
    vec3 up=normalize(cross(a,cross(a,vec3(0,1,0))));
    return vec2(dot(g,up),dot(g,cross(up,normalize(a))));
}

float ease_out_expo(float x)
{
	float t=x; float b=0.; float c=1.; float d=1.;
	return (t==d) ? b+c : c * (-pow(2., -10. * t/d) + 1.) + b;
}

float map(vec3 p)
{
	p.zy*=rot(time*0.3);
    p.xy*=rot(time*0.8);
	p-=clamp(p,-5.0,5.0);
	vec2 q =vec2(abs(length(p)-3.0),p.z);
    return  abs(length(q)-1.5);
}

void main()
{
	vec2 p = (gl_FragCoord.xy*2.0-resolution)/resolution.y;
    vec3 ro = vec3(0,0,30);
    vec3 rd=normalize(vec3(p,-2));
    vec3 col = vec3(0)+length(p*vec2(1,1.5))*0.15;
    for(float i=-10.0; i<10.0;i++)
    {
        vec2 uv=billboardUv(ro,rd,vec3(0,0,i));
 		vec3 p = vec3(uv,i);
        float de=map(p);
        col+=mix(hue(0.05),vec3(0),clamp(ease_out_expo(de),0.05,1.8));
    }
    col=min(vec3(1),col);
    gl_FragColor = vec4(col, 1.0);
}
