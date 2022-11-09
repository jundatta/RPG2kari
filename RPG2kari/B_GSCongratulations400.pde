// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】Richard Bourneさん
// 【作品名】Soothing Circles
// https://openprocessing.org/sketch/1483539
//

class GameSceneCongratulations400 extends GameSceneCongratulationsBase {
  float n, m, f1, f2, f3;

  @Override void setup() {
    colorMode(HSB, 255, 255, 255);
    background(20);
    smooth();
    noStroke();
    fill(255);

    n = 120;      // number of ellipse per circle
    m = 100;      // magnitude of waves
    f1 = 1000;    // f general
    f2 = 2;       // f of rotation
    f3 = 5;       // f of waves
  }
  @Override void draw() {
    push();
    background(0);
    var t = millis()/f1;

    paintCircle(t, 0);
    paintCircle(t, PI);
    pop();

    logoRightLower(#ff0000);
  }

  void paintCircle(float t, float o) {
    for (float i = 0; i < n; i++) {
      float p = (i/n)*TWO_PI;
      float x = (width/2) + sin(p+t) * (200+sin((t*f2+p)*f3+o)*m*(1-sin(p)));
      float y = (height/2) + cos(p+t) * (200+sin((t*f2+p)*f3+o)*m*(1-sin(p)));
      fill(i/n * 255, 200, 255);
      ellipse(x, y, 8, 8);
    }
  }
  
  @Override void mousePressed() {
    gGameStack.change(new GameSceneTitle());
  }
  @Override void keyPressed() {
    super.keyPressed();

    gGameStack.change(new GameSceneTitle());
  }
}
