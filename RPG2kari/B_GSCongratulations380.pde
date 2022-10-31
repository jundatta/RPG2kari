// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】phi16さん
// 【作品名】NeonCube
// https://www.shadertoy.com/view/XtdGRs
//

class GameSceneCongratulations380 extends GameSceneCongratulationsBase {
  PShader sd, bfA;
  int startMillis;
  int startCount;

  @Override void setup() {
    noStroke();
    textureWrap(REPEAT);

    bfA = loadShader("data/380/bufferA.glsl");
    bfA.set("iResolution", (float)width, (float)height, 0.0f);

    sd = loadShader("data/380/Shadertoy.glsl");
    sd.set("iResolution", (float)width, (float)height, 0.0f);
    // 最初のミリ秒を取り込んでおく
    startMillis = millis();
    startCount = frameCount;
  }
  @Override void draw() {
    push();
    float iTime = (millis() - startMillis) / 1000.0f;

    bfA.set("iTime", iTime);
    shader(sd);
    rect(0, 0, width, height);
    resetShader();

    // loadPixels()を呼ぶと
    // "The pixels array is null."
    // は表示されなくなる。
    // （ただし描かれる絵が変わる様子はない。。。）
    //loadPixels();
    sd.set("iTime", iTime);
    sd.set("iChannel0", getGraphics());
    shader(sd);
    rect(0, 0, width, height);
    resetShader();
    //updatePixels();
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
