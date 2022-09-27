precision highp float;

uniform vec2 resolution;
uniform float time;
uniform vec2 mouse;
uniform sampler2D backbuffer;

float cubicInOut(float t) {
	return t < 0.5
	?  4.0 * t * t * t
	: -4.0 * pow(t - 1.0, 3.0) + 1.0;
}

float ripple(vec2 iPos){
    return sin(length(iPos) * 0.3 - time * 3.0);
}

float border(vec2 iPos){
    return sin(iPos.x * 0.8 - time * 3.0);
}

float swirl(vec2 iPos){
    return sin(atan(iPos.y, iPos.x) * 5.0 + time * 3.0);
}

float sinWave(vec2 iPos){
    float wave = iPos.y + sin(iPos.x * 10.0 + time + 4.0) * 20.5;
    return 0.3 /abs(wave + 0.1);
}

vec3 lattice(vec2 uv, float size) {
    vec2 r = vec2(1, 1.73);
    vec2 h = r*.5;
    vec3 color = vec3(0.0);
    vec2 uv2 = uv * size;
    vec2 a = mod(uv2, r)-h;
    vec2 b = mod(uv2-h, r)-h;
    vec2 gv = dot(a, a) < dot(b,b) ? a : b;
    vec2 iPos = gv - uv2;

    float t = time * 0.8;
    int index = int(mod(t, 4.0));
    float aTime = smoothstep(0.2, 0.8, cubicInOut(mod(t, 1.0)));
    if(index == 0){
        color += mix(ripple(iPos), border(iPos), aTime); 
    }else if(index == 1){
        color += mix(border(iPos), swirl(iPos), aTime); 
    }else if(index == 2){
        color += mix(swirl(iPos), sinWave(iPos), aTime);
    }else{
        color += mix(sinWave(iPos), ripple(iPos), aTime);
    }

    return color;
}

vec3 renderingFunc(vec2 uv){
    vec3 color = vec3(0.0);

    color.r += lattice(uv, 20.0).r;
    color.g += lattice(uv, 21.0).g;
    color.b += lattice(uv, 22.0).b;

    return color;
}

void main(){
    vec2 uv = (gl_FragCoord.xy * 2.0 - resolution.xy) / min(resolution.x, resolution.y);
    vec3 color = renderingFunc(uv);
    gl_FragColor = vec4(color, 1.0);
}

