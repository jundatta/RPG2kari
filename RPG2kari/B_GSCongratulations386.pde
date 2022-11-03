// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】独楽回しeddyさん
// 【作品名】TodaySky
// https://neort.io/art/c89p5ns3p9f5abd6m3e0
//

class GameSceneCongratulations386 extends GameSceneCongratulationsBase {
  PShader s;
  int startMillis;
  @Override void setup() {
    noStroke();
    s = loadShader("data/386/neort.glsl");
    s.set("resolution", width, height);
    // 最初のミリ秒を取り込んでおく
    startMillis = millis();
  }
  @Override void draw() {
    push();
    s.set("backbuffer", getGraphics());
    s.set("time", (millis() - startMillis) / 1000.0f);
    s.set("mouse", (float)mouseX / (float)width, (float)mouseY / (float)height);
    shader(s);
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
