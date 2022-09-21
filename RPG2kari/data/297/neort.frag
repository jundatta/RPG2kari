precision highp float;

uniform vec2 resolution;

const float PI = acos(-1.);
mat3 rotX(float q){return mat3(1.,0.,0.,0.,cos(q),-sin(q),0.,sin(q),cos(q));}
mat3 rotY(float q){return mat3(cos(q),0.,sin(q),0.,1.,0.,-sin(q),0.,cos(q));}
mat3 rotZ(float q){return mat3(cos(q),-sin(q),0.,sin(q),cos(q),0.,0.,0.,1.);}
float random(vec2 p){return fract(sin(dot(p,vec2(12.9898,78.233)))*43758.5453);}

float WIRE_R = .08;

// SDF from https://www.iquilezles.org/www/articles/distfunctions/distfunctions.htm
float sdCappedCylinder( vec3 p, float h, float r )
{
  vec2 d = abs(vec2(length(p.xz),p.y)) - vec2(h,r);
  return min(max(d.x,d.y),0.0) + length(max(d,0.0));
}

float dCore1(vec3 p){
  p = rotZ(PI/4.)*p;
  p.x = mod(p.x+sqrt(2.)/2., sqrt(2.))-sqrt(2.)/2.;
  p.y = mod(p.y+sqrt(2.)/2., sqrt(2.))-sqrt(2.)/2.;
  float d = max(sdCappedCylinder(p, .4,.12),-sdCappedCylinder(p, .28,.2));
  return d;
}

float dCore2(vec3 p){
  p.x += 1.;
  p = rotZ(-PI/4.)*p;
  p.x = mod(p.x+sqrt(2.)/2., sqrt(2.))-sqrt(2.)/2.;
  p.y = mod(p.y+sqrt(2.)/2., sqrt(2.))-sqrt(2.)/2.;
  float d = max(sdCappedCylinder(p, .4,.12),-sdCappedCylinder(p, .28,.2));
  return d;
}

float dCore(vec3 p){
  float d = min(dCore1(p),dCore2(p));
  return d;
}

float dFloor(vec3 p){
  float d = (-p.z + .5);
  return d;
}

float dFrontWires(vec3 p){
  p.x = mod(p.x+0.5, 1.) - 0.5;
  float d = length(vec2(p.x, p.z+WIRE_R*1.5)) - WIRE_R;
  return d;  
}

float dBackWires(vec3 p){
  p.y = mod(p.y+0.5, 1.) - 0.5;
  float d = length(vec2(p.y, p.z-WIRE_R*1.5)) - WIRE_R;
  return d;  
}

float distFunc(vec3 p){
  float d = 1e3;
  d = min(d, dFrontWires(p));
  d = min(d, dBackWires(p));
  d = min(d, dFloor(p));
  d = min(d, dCore(p));
  return d;
}

vec3 normFunc(vec3 p){
    float d = 0.001;
  	float dx = distFunc(p+vec3(d, 0., 0.)) -  distFunc(p);
  	float dy = distFunc(p+vec3(0., d, 0.)) -  distFunc(p);
  	float dz = distFunc(p+vec3(0., 0., d)) -  distFunc(p);
    
    return normalize(vec3(dx, dy, dz));
}

vec3 colorFunc(vec3 p){
  float d_fwire = dFrontWires(p);
  float d_bwire = dBackWires(p);
  float d_floor = dFloor(p);
  float d_core = dCore(p);

  if (d_fwire < d_bwire && d_fwire < d_floor && d_fwire < d_core){
    return vec3(0.8,0,0);
  } else if (d_bwire < d_floor && d_bwire < d_core){
    return vec3(0,0.5,.2);
  } else if (d_core < d_floor){
    return vec3(.3)+random(p.xy+p.zy)*.1;
  }

  return vec3(1);
}

void main(){
  //短辺が-1~1となる二次元座標
    vec2 p = (gl_FragCoord.xy * 2.0 - resolution.xy) / min(resolution.x, resolution.y);

  //カメラの位置、向き
  vec3 cDir  = normalize(vec3(0., 2., 4.));
  vec3 cPos  = -cDir*12.;
  vec3 cUp   = normalize(vec3(0., 1., 0.));
  vec3 cSide = cross(cDir,cUp);

  // レイ
  vec3  rDir = normalize(cSide * p.x + cUp * p.y + cDir * 2.);
  vec3  rPos = cPos;

  //　点光源
  vec3 lPos = normalize(vec3(1,1,-3))*8.;
  // vec3 lPos = cPos;

  // マーチングループ
  float d, dLim = 1e-3;
  for (int i=0; i<200; i++){
    d = distFunc(rPos);
    if (d < dLim) break;

    rPos += d * rDir;
  }

  // 影のマーチングループ
  vec3 shDir = normalize(lPos-rPos);
  vec3 shPos = rPos + shDir*dLim*100.;
  bool shaded = false;
  float shD;
  for (int i=0; i<200; i++){
    shD = distFunc(shPos);

    if (length(shPos - lPos) < dLim) {
      // 光源にたどり着いたら影なし
      break;
    } else if (shD < dLim) {
      // 光源にたどり着かずに何かに衝突したら影なし
      shaded = true;
      break;
    }

    shPos += shD * shDir;
  }


  // 色の設定
  vec3 color = colorFunc(rPos);
  float r = length(rPos - lPos);
  float shade = clamp(dot(-normFunc(rPos), normalize(rPos-lPos)), 0., 1.);
  shade *= 80./r/r;

  if (shaded) {
    shade *= 0.5;
  }

  gl_FragColor = vec4(color*shade, 1.);
}
