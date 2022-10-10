// こちらがオリジナルです。
// 【作者】Kaliさん
// 【作品名】Hot Shower
// https://www.shadertoy.com/view/4lf3Rj

PShader sd;
int startMillis;

void setup() {
  size(787, 442, P3D);
  noStroke();
  textureWrap(REPEAT);

  sd = loadShader("Shadertoy.glsl");
  sd.set("iResolution", (float)width, (float)height, 0.0f);
  // 最初のミリ秒を取り込んでおく
  startMillis = millis();
  sd.set("iChannel0", loadImage("iChannel0.png"));
  sd.set("iChannel1", loadImage("iChannel1.png"));
}

void draw() {
  // ※Shadertoyの場合、透明度は指定しても反映されない
  // void mainImage( out vec4 fragColor, in vec2 fragCoord )の
  // fragCoordの透明度の指定は反映されない
  // なのでfragCoordの透明度は1.0（不透明）固定で返すように注意する
  //  background(0);
  // 最初からのミリ秒として渡したいのでstartMillisをmillis()から引く
  sd.set("iTime", (millis() - startMillis) / 1000.0f);
  // iMouseのz,wはそれぞれマウスドラッグ時のx,y座標になるが
  // シミュレートをあきらめる
  // このためz,wにはそれぞれ0.0fを固定で渡す
  sd.set("iMouse", (float)mouseX, (float)mouseY, 0.0f, 0.0f);
  shader(sd);
  rect(0, 0, width, height);
  resetShader();
}
