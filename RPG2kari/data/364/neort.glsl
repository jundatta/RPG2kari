// ‚±‚¿‚ç‚ªƒIƒŠƒWƒiƒ‹‚Å‚·B
// yìŽÒzgaz‚³‚ñ
// yì•i–¼zNo title 33
// https://neort.io/art/bn7b9vk3p9f5erb51qg0

precision mediump float;
uniform vec2  resolution;
uniform float time;

out vec4 fragColor;

#define PI acos(-1.0)
#define TAU PI*2.0

#define rot(a) mat2(cos(a), sin(a), -sin(a), cos(a))
#define hue(t) (cos((vec3(0,2,-2)/3.0+t)*TAU)*0.5+0.5)

vec3 rot3D(vec3 p,vec3 a,float t) 
{
	a=normalize(a);
	vec3 v=cross(a,p),u=cross(v,a);
	return u*cos(t)+v*sin(t)+a*dot(p, a);   
}

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

// https://www.shadertoy.com/view/tt23RR
float sdHexagram(vec2 p, float r )
{
    const vec4 k = vec4(-0.5,0.8660254038,0.5773502692,1.7320508076);
    p = abs(p);
    p -= 2.0*min(dot(k.xy,p),0.0)*k.xy;
    p -= 2.0*min(dot(k.yx,p),0.0)*k.yx;
    p -= vec2(clamp(p.x,r*k.z,r*k.w),r);
    return length(p)*sign(p.y);
}

float castLine(vec3 ro, vec3 rd, vec3 a, in vec3 b)
{
    vec3 ab =normalize(b-a),ao = a-ro;
    float d0 = dot(rd, ab), d1 = dot(rd, ao), d2 = dot(ab, ao);
    float len = (d0*d1-d2)/(1.0-d0*d0);
    len= clamp(len,0.0,length(b-a));
    vec3 p = a+ab*len;
    return length(cross(p-ro, rd));
}

vec3 tetraCoord(int i)
{
    i=i%4;
    return vec3(9>>i&1, i>>1&1, i&1)*2.0-1.0;
}

vec3 transform(vec3 p)
{
    p.yz*=rot(time);
    p.xz*=rot(time*0.2);
    return p;
}

void main(){
    vec2 p = (gl_FragCoord.xy * 2.0 - resolution) / resolution.y;
    vec3 ro = vec3(0,0,5);
    ro=rot3D(ro,vec3(1,2,3),time*0.8);
    vec3 w=normalize(-ro),u=normalize(cross(w,vec3(0,1,0)));
	vec3 rd=normalize(u*p.x+cross(u,w)*p.y+w*2.);
    vec3 col = vec3(0.0)+p.y*p.y*0.3;
    vec3 up=vec3(0,1,0);
    float d=1.5;
    for(int j=0;j<4;j++)
    {
        for(int i=0; i<4;i++)
        {
            vec3 c = tetraCoord(i);
            c=transform(c);
            c+=tetraCoord(j)*d;
            vec3 c2 = tetraCoord(i+1);
            c2=transform(c2);
            c2+=tetraCoord(j)*d;
            vec2 uv=billboardUv(ro,rd,c);
            float sdf=sdHexagram(uv,0.2);
            col+=mix(hue(float(i+j*4)/12.0),vec3(0),smoothstep(0.0,0.053,sdf));
            float de=castLine(ro,rd,c,c2);
            col+=mix(hue(0.1)*0.5,vec3(0),clamp(ease_out_expo(de),0.0,1.0));
        }
        for(int i=0; i<2;i++)
        {
            vec3 c = tetraCoord(i);
            c=transform(c);
            c+=tetraCoord(j)*d;
            vec3 c2 = tetraCoord(i+2);
            c2=transform(c2);
            c2+=tetraCoord(j)*d;
            float de=castLine(ro,rd,c,c2);
            col+=mix(hue(0.05)*0.3,vec3(0),clamp(ease_out_expo(de),0.0,1.0));
        }
    }
    col=min(vec3(1),col);
    fragColor=vec4(col,1.0);
}
