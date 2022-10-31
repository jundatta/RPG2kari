// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】reinderさん
// 【作品名】Misty Lake
// https://www.shadertoy.com/view/MsB3WR
//

class GameSceneCongratulations376 extends GameSceneCongratulationsBase {
  PShader sd;
  int startMillis;
  int startCount;

  @Override void setup() {
    noStroke();
    textureWrap(REPEAT);

    sd = loadShader("data/376/Shadertoy.glsl");
    sd.set("iResolution", (float)width, (float)height, 0.0f);
    // 最初のミリ秒を取り込んでおく
    startMillis = millis();
    startCount = frameCount;
    // iChannel0。。。noise()の元ネタの画像。
    // ⇒画像が荒いと霧が発生しない。細かい画像で霧が発生した（うまくいくようになった）
    // ⇒画像の細かさを比べるためにShadertoyのホームページでも表示させてみるとよくわかる！！
    //  fragColor = texture(iChannel0, q);
    sd.set("iChannel0", loadImage("data/376/iChannel0.png"));
    sd.set("iChannel1", loadImage("data/376/iChannel1.jpg"));
    sd.set("iChannel2", loadImage("data/376/iChannel2.jpg"));
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
    //sd.set("iFrame", frameCount - startCount);
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
