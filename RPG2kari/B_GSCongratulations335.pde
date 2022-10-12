// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】Kaliさん
// 【作品名】Britney's Spaceship
// https://www.shadertoy.com/view/4tX3Rj
//

class GameSceneCongratulations335 extends GameSceneCongratulationsBase {
  PShader sd;
  int startMillis;

  @Override void setup() {
    noStroke();
    textureWrap(REPEAT);

    sd = loadShader("data/335/Shadertoy.glsl");
    sd.set("iResolution", (float)width, (float)height, 0.0f);
    // 最初のミリ秒を取り込んでおく
    startMillis = millis();
    sd.set("iChannel0", loadImage("data/335/iChannel0.png"));
  }
  @Override void draw() {
    push();
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
    pop();

    logoRightLower(#ff0000);
  }
  @Override void mousePressed() {
    gGameStack.change(new GameSceneTitle());
  }
  @Override void keyPressed() {
    super.keyPressed();

    gGameStack.change(new GameSceneTitle());
  }
}
