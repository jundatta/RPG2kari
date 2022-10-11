// Ç±ÇøÇÁÇ™ÉIÉäÉWÉiÉãÇ≈Ç∑ÅB
// ÅyçÏé“ÅzgazÇ≥ÇÒ
// ÅyçÏïiñºÅzNo Title 04
// https://neort.io/art/bivcfsc3p9f9psc9oo40

precision highp float;

uniform vec2 resolution;
uniform float time;

#define iResolution resolution
#define iTime time
void mainImage(out vec4 fragColor, in vec2 fragCoord);
void main(){mainImage(gl_FragColor, gl_FragCoord.xy);}

vec2 rotate(vec2 p, float theta)
{
    return p * cos(theta) + vec2(-p.y, p.x) * sin(theta);
}

float map(vec3 p)
{
    p.z += iTime*2.0;
    p.y -= -3.0;
    float c = 3.0;
    p.xz= mod(p.xz,c)-c*0.5;
    return length(p)-0.8;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 p = (gl_FragCoord.xy * 2.0 - iResolution.xy) / iResolution.y;
    p.x += sin(iTime*0.5+0.6*sin(iTime*0.5))*0.3;
    p.y += sin(iTime*0.2+0.3*sin(iTime))*0.2;
    vec3 ro = vec3(0,0,0);
    vec3 rd = normalize(vec3(p, -3.0-dot(p, p)*10.0)).xzy;
    rd.xz +=sin(rd.xz*50.0+iTime*0.3)*(3.0+sin(iTime*0.5)*1.5);
    rd = normalize(rd);
    rd.xy=rotate(rd.xy,sin(iTime*0.5+0.5*sin(iTime*0.5))*0.3);
    rd.xz=rotate(rd.xz,iTime*0.5);
	float t=0.0,d;
	for(int i = 0; i < 30; i++)
  	{
		vec3 p=ro + rd * t; 
    	t += d =map(p)*0.2;
    	if (d < 0.01) break;
    }
 	vec3 col = vec3(0.1,0.8,0.6)*0.05/d;
    col = clamp(col,0.0,1.0);
    col = pow(col,vec3(2.5));
    fragColor = vec4(col, 1.0);
}
