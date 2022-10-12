// ‚±‚¿‚ç‚ªƒIƒŠƒWƒiƒ‹‚Å‚·B
// yìŽÒzfotfla‚³‚ñ
// yì•i–¼zSnowy Sky
// https://neort.io/art/bvnhsls3p9f30ks56al0

precision highp float;

uniform vec2 resolution;
uniform float time;
uniform vec2 mouse;
uniform sampler2D backbuffer;

#define PI 3.14159265


#define isNight 0.0

// Reference 2d distance function indigoQuilez
// https://www.iquilezles.org/www/articles/distfunctions2d/distfunctions2d.htm

vec2 rotate(vec2 p, float a){
	float c = cos(a), s = sin(a);
	return mat2(c,s,-s,c)*p;
}

vec2 pmod(vec2 p, float n){
	float a = atan(p.x,p.y) + PI /n;
	float r = PI * 2.0 / n;
	a = floor(a/r) * r;
	return rotate(p,a);
}

float opSmoothUnion( float d1, float d2, float k ) {
   float h = clamp(0.5 + 0.5*(d2-d1)/k,0.0,1.0);
   return mix( d2, d1, h ) - k*h*(1.0-h);
}

float sdCircle(vec2 p,float r){
	return length(p) - r;
}

float sdHexagon(vec2 p, float r){
    const vec3 k = vec3(-0.866025404,0.5,0.577350269);
    p = abs(p);
    p -= 2.0 * min(dot(k.xy,p),0.0) * k.xy;
    p -= vec2(clamp(p.x,-k.z * r,k.z * r), r);
    return length(p) * sign(p.y);
}

float sdLine(vec2 p, vec2 a,vec2 b){
    vec2 pa = p - a;
    vec2 ba = b - a;
    float h = clamp(dot(pa,ba)/dot(ba,ba),0.0,1.0);
    return length(pa - h * ba);
}

float sineWave(vec2 p,float amp, float wave,float offset,float width){
	float s = sin(p.x * PI * wave + offset) * amp;
    float c = cos(p.x * PI * wave + offset) * amp;
	return smoothstep(0.001,0.0,abs(s - p.y) / sqrt(1.0 + c * c)  - width);
}

float hash(vec2 uv){
    return fract(43531.53671 * sin(dot(uv,vec2(12.8989,72.599))));
}

vec3 HexSnow(vec2 uv){
    uv -= 0.5;
    vec2 p = pmod(uv,6.0);

    float outColor = 0.0;
    float o = 0.0;
    float l = sdLine(p,vec2(0,0),vec2(0,0.45));
    vec2 p0 = p;
    p0 = rotate(p0,PI / 6.0);
    float he0 = sdHexagon(p0,0.1);
    float he1 = sdHexagon(p0,0.05);
    vec2 p1 = p;
    p1.x = abs(p1.x);
    float l2 = sdLine(p1,vec2(0.1,0.45),vec2(0.0,0.35));
    float l3 = sdLine(p1,vec2(0.1,0.3) ,vec2(0.0,0.2));
    o = min(he0,l);
    o = min(o,l2);
    o = min(o,l3);
    o = max(-he1,o);
    outColor += smoothstep(0.05,0.0,o);

    return vec3(outColor);
}

vec3 tex(vec2 uv){
    const vec3 snowColor = vec3(0.5,0.8,1.0);
    const vec3 skyColor = vec3(0.6,0.75,1.0);
    const vec3 nightColor = vec3(0.01,0.015,0.03);
    const vec3 horizonColor = vec3(0.9,0.85,1.0);

    // Yama
    vec3 outColor = vec3(0.0);
    vec2 p = uv;
    float sw0 = sineWave(p + vec2(0,0.46),0.2,1.5,time * 0.1,0.1);
    float sw0shdow = sineWave(p + vec2(0,0.46),0.2,1.5,time * 0.1,0.1);
    float sw1 = sineWave(p + vec2(0.0,0.23),0.1,1.3,time * 0.25,0.05);
    float sw1Shadow = sineWave(p + vec2(0.0,0.23),0.1,1.3,time * 0.25,0.055);
    outColor += clamp(sw0 - sw1Shadow,0.0,1.0) + sw1;

    // Snow
    vec2 p0 = uv * 10.0;
    vec2 i0 = floor(p0);
    float h0 = hash(vec2(i0.x * 100.0)) + 0.1;
    
    p0.y += h0 * time * 0.5 + h0 * 10.0;
    float h1 = hash(floor(p0));
    vec2 f0 = fract(p0);
    f0 = rotate(f0 - 0.5,time * 0.25) + 0.5;
    outColor += h1 > 0.85 ? HexSnow(f0) * snowColor : vec3(0.0);
    
    vec2 p1 = uv * 30.0;
    vec2 i1 = floor(p1);
    float h2 = hash(vec2(i1.x * 100.0)) + 0.1;
    
    p1.y += h2 * time * 0.5 + h2 * 10.0;
    float h3 = hash(floor(p1));
    vec2 f1 = fract(p1);
    f1 = rotate(f1 - 0.5,time * 0.25) + 0.5;
    outColor += h3 > 0.85 ? HexSnow(f1) * snowColor : vec3(0.0);

    // Cloud
    p = uv;
    p.y -= 0.5;
    vec2 p2 = p;
    p2.x += time * 0.02;
    p2.x = fract(p2.x + 0.4) - 0.5;
    float b = 1.0;
    float b0 = sdLine(p2 + vec2(0.0,-0.4),vec2(0.0,0.0),vec2(0.125,0.0)) - 0.0125;
    float b1 = sdLine(p2 + vec2(0.0,-0.35),vec2(0.04,0.0),vec2(0.325,0.0)) - 0.0125;
    float b2 = sdLine(p2 + vec2(0.0,-0.35),vec2(0.1,0.00125),vec2(0.1,0.0325)) - 0.0125;

    b = min(b0,b);
    b = opSmoothUnion(b1,b,0.01);
    b = opSmoothUnion(b2,b,0.01);

    vec2 p3 = p;
    p3.x += time * 0.0125;
    p3.x = fract(p3.x) -0.5;

    float b3 = sdLine(p3 + vec2(0.0,-0.3),vec2(0.0,0.0),vec2(0.1,0.0)) - 0.0125;
    float b4 = sdLine(p3 + vec2(0.0,-0.25),vec2(0.05,0.0),vec2(-0.1,0.0)) - 0.0125;
    float b5 = sdLine(p3 + vec2(0.0,-0.2),vec2(-0.05,0.0),vec2(0.175,0.0)) - 0.0125;
    float b6 = sdLine(p3 + vec2(0.0,-0.3),vec2(0.025,0.00125),vec2(0.025,-0.0325)) - 0.0125;
    float b7 = sdLine(p3 + vec2(0.0,-0.25),vec2(-0.025,0.00125),vec2(-0.025,-0.0325)) - 0.0125;
    b = min(b3,b);
    b = opSmoothUnion(b4,b,0.001);
    b = opSmoothUnion(b5,b,0.001);
    b = opSmoothUnion(b6,b,0.001);
    b = opSmoothUnion(b7,b,0.001);

    outColor += smoothstep(0.01,0.0,b);

    outColor = clamp(outColor,0.0,1.0);

    vec3 bg = mix(horizonColor,mix(skyColor,nightColor,isNight),clamp(uv.y + 0.7,0.0,1.0)) * (1.0 - outColor);
    outColor += bg;

    return outColor;
}

void main(void) {
    vec2 uv = (gl_FragCoord.xy * 2.0 - resolution.xy) / min(resolution.x, resolution.y);
    
    vec3 color = tex(uv);

    gl_FragColor = vec4(color, 1.0);
}
