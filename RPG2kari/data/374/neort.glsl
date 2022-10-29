// Ç±ÇøÇÁÇ™ÉIÉäÉWÉiÉãÇ≈Ç∑ÅB
// ÅyçÏé“Åzyasai-gyaboÇ≥ÇÒ
// ÅyçÏïiñºÅzY Metal
// https://neort.io/art/bivecbs3p9f9psc9oo8g

// MIT Lisence : https://opensource.org/licenses/MIT
// Copyright (c) 2019 @gyabo
precision mediump float;

uniform vec2 resolution;
uniform float time;
uniform vec2 mouse;


#define RAY_ITEMAX   25
#define RAY_TH       1.0
#define RAY_ACC_DIST 16.0 + sin(time * 0.125) * 2.0 //okonomi
#define FOG_COLOR    vec3(1,2,5)
#define FOG_DENS     0.0015
#define LIGHT_DIR    vec3(1,2,3)

vec2 rot(vec2 p, float a) {
	float c = cos(a);
	float s = sin(a);
	return vec2(
		p.x * c - p.y * s,
		p.x * s + p.y * c);
		
}

float map(vec3 p) {
	float t = cos(p.x) + cos(p.y);
	p.xy = rot(p.xy, 0.5);	
	t = max(t, -(length(mod(p.z, 10.0) - 5.0) - 5.25));
    //t = max(t, -(length(mod(p.yz, 10.0) - 5.0) - 5.25));
	return t;
}

vec3 getnor(vec3 p) {
	vec2 dd = vec2(0.01, 0.0);
	float k = map(p);
	return normalize(vec3(
        k - map(p + dd.xyy),
        k - map(p + dd.yxy),
        k - map(p + dd.yyx))
    );
	
}

void main( void ) {

	vec2 uv = ( 2.0 * gl_FragCoord.xy - resolution.xy ) / min(resolution.x, resolution.y);
	vec3 dir = normalize(vec3(uv, 1.0));
	

	dir.yz = rot(dir.yz, -1.0 - time * 0.07);

	vec3 pos = vec3(0, 0.0, time * 1.0);
	float t = 0.0;
    
	for(int i = 0 ; i < RAY_ITEMAX; i++) {
		float temp = map(t * dir + pos);
		if(temp < RAY_TH) break;
		t += RAY_ACC_DIST;
        if(fract(time * 0.05) * 60.0 < 30.0) {
			dir = dir.yzx;
        }
	}
	vec3 ip = t * dir + pos;
	vec3 L = normalize(LIGHT_DIR);
	vec3 V = normalize(ip);
	vec3 N = getnor(ip);
	vec3 H = normalize(V + N);
	float D = max(0.0, dot(L, N));
	float S = max(0.0, pow(max(0.1, dot(L, H)), 10.0));
	vec3 col = vec3(0.0);
	vec3 fogcol = FOG_COLOR;
	col += t * FOG_DENS * fogcol;

	gl_FragColor = vec4(S * fogcol.zyx + D * col + col, 1.0);

}
