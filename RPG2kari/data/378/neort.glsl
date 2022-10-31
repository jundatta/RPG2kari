// こちらがオリジナルです。
// 【作者】寝る前さん
// 【作品名】20200312
// https://neort.io/art/bpl3j1c3p9fbkbq83idg

precision highp float;

uniform vec2 resolution;
uniform float time;
const float pi = acos(-1.);
const float pi2 = pi*2.;

mat2 rot(float r)
{
  float s = sin(r),c = cos(r);
  return mat2(c,s,-s,c);
}

vec2 pmod(vec2 p,float r)
{
  float a = atan(p.x,p.y) + pi/r;
  float n = pi2/r;
  a = floor(a/n)*n;
  return p*rot(-a);
}

float sphere(vec3 p,float r)
{
  return length(p)-r;
}

float box(vec3 p,float r)
{
  p = abs(p) - r;
  return max(max(p.x,p.y),p.z);
}

float dist(vec3 p)
{
  float d = 9999.;
  float k = .5;
  float id= floor(p.y/k);
  float kk = 10.;
  //p.xz = mod(abs(p.xz),kk)-kk*0.5;
  
  
  p.xz *= rot(id);
  
  p.y = mod(abs(p.y),k)-k*0.5;
  p.xz = pmod(p.xz,8.);
  
  p.z -= 1.+sin(id+time)*0.5;
  
  for(int i = 0;i<5;i++)
  {
    p = abs(p)-.13;
    p.xy *= rot(1.+id+time*0.5);
    
  }
  d = min(d,box(p,.1+(sin(id+time)*0.5)*0.1));
  return d;
}

vec3 normal(vec3 p)
{
  float e = 0.001;
  vec2 k = vec2(1.,-1.);
  return normalize(
    k.xyy * dist(p+k.xyy*e)+
    k.yxy * dist(p+k.yxy*e)+
    k.yyx * dist(p+k.yyx*e)+
    k.xxx * dist(p+k.xxx*e))
    ;
}

float ao(vec3 p,vec3 n,float len,float power){
	float oss =0.0;
	for(int i =0;i<3;i++){
		float d = dist(p+n*len/3.0*float(i+1));
		oss += (len-d)*power;
		power *=0.5;
	}
	return clamp(1.-oss,0.0,1.0);
}

void main(void) {
    vec2 uv = (gl_FragCoord.xy * 2.0 - resolution.xy) / min(resolution.x, resolution.y);
    uv.xy *= rot(pi*0.5);
    float cc = .2-fract(time*2.)*0.2;
    vec3 ro = vec3(0.,0.-time*0.2,-5.),ta = vec3(0.,0.-time*0.2,0.);
    ro.xz *= rot(time*0.2);
    vec3 fo = normalize(ta-ro),le = normalize(cross(vec3(0.,1.,0.),fo)),up = normalize(cross(fo,le));
    vec3 rd = normalize(fo*(1.0-(dot(uv,uv)*0.2))+up*uv.y+le*uv.x);
	// neortさんやglslfan.comさんはauto変数？の初期値は0クリアされる仕様なのかも知れない。。。
	// というかGLSL自体の仕様は0クリアされる？のかも？！
//    vec3 col,pos;
    vec3 pos;
    vec3 col = vec3(0.0);	// 初期値の0クリアを追加した。
    float t = 0.01,d;
    int ma;

    for(int i = 0;i<99;i++)
    {
      ma = i;
      pos=  ro + rd*t;
      d = dist(pos);
      if(d<0.01)
      {
        vec3 n = normal(pos);
        float k = 2.;
        float len = (0.02+cc)/length(mod(abs(pos.y+time*.5),k)-k*0.5);
        vec3 ld = normalize(vec3(0.,1.,0.));
        
        float la = dot(n,ld);
        float spec = pow(clamp(dot(reflect(ld,n),rd),0.,1.),10.);
        col = vec3(la*vec3(1.,1.,2.)+spec*vec3(1.,1.,5.)+len*vec3(1.,1.,5.));
        break;
      }
      t += d*0.5;
    }
    float fog = max(0.,(1./99.)*float(ma));
    col = col * fog;

    gl_FragColor = vec4(col, 1.0);
}
