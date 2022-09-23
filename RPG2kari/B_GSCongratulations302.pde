// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】gazさん
// 【作品名】No Title 36
// https://neort.io/art/bnb7t7k3p9f5erb527s0
//

class GameSceneCongratulations302 extends GameSceneCongratulationsBase {
  PShader s;

  @Override void setup() {
    noStroke();
    s = loadShader("data/302/neort.glsl");
    s.set("resolution", width, height);
  }
  @Override void draw() {
    push();
    s.set("backbuffer", getGraphics());
    s.set("time", millis() / 1000.0f);
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
