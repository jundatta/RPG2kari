// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】Yusef28さん
// 【作品名】Tunnel Experiment #2
// https://www.shadertoy.com/view/stG3W1
//

class GameSceneCongratulations367 extends GameSceneCongratulationsBase {
  PShader sdA;
  int startMillis;

  @Override void setup() {
    noStroke();
    textureWrap(REPEAT);

    sdA = loadShader("data/367/bufferA.glsl");
    sdA.set("iResolution", (float)width, (float)height, 0.0f);
    // 最初のミリ秒を取り込んでおく
    sdA.set("iChannel0", loadImage("data/367/iChannel0.jpg"));
    sdA.set("iChannel1", loadImage("data/367/iChannel1.jpg"));
    sdA.set("iChannel2", loadImage("data/367/iChannel2.jpg"));
  }
  @Override void draw() {
    push();
    sdA.set("iTime", (millis() - startMillis) / 1000.0f);
    shader(sdA);
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
