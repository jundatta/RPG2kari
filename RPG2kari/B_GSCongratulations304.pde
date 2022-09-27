// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】Sjeitiさん
// 【作品名】Sparks drifting
// https://www.shadertoy.com/view/MlKSWm
//

class GameSceneCongratulations304 extends GameSceneCongratulationsBase {
  PShader sd;
  int startMillis;

  @Override void setup() {
    noStroke();

    sd = loadShader("data/304/Shadertoy.glsl");
    sd.set("iResolution", (float)width, (float)height, 0.0f);
    // 最初のミリ秒を取り込んでおく
    startMillis = millis();
  }
  @Override void draw() {
    push();
    sd.set("iTime", (millis() - startMillis) / 1000.0f);
    sd.set("iMouse", (float)mouseX, (float)mouseY, 0.0f, 0.0f);
    shader(sd);
    rect(0, 0, width, height);
    resetShader();
    pop();

    logoRightUpper(#ff0000);
  }
  @Override void mousePressed() {
    gGameStack.change(new GameSceneTitle());
  }
  @Override void keyPressed() {
    super.keyPressed();

    gGameStack.change(new GameSceneTitle());
  }
}
