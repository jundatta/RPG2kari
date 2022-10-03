// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】Athena Nieさん
// 【作品名】Parallax
// https://openprocessing.org/sketch/1127780
//

class GameSceneCongratulations311 extends GameSceneCongratulationsBase {
  float[] heights = {120, 160, 200, 240, 280, 320, 360};
  float[] function1 = new float[21];
  float[] function2 = new float[21];
  float[] function3 = new float[21];
  int i;
  int x;

  @Override void setup() {
    colorMode(RGB, 100);
    background(75);
    for (i = 0; i < 7; i++) {
      function1[3*i] = (1-0.1*i)*random(50, 55);
      function1[3*i+1] = random(0.009, 0.015);
      function1[3*i+2] = random(-100, 100);
    }

    for (i = 0; i < 7; i++) {
      function2[3*i] = (1-0.1*i)*random(25, 30);
      function2[3*i+1] = random(0.01, 0.02);
      function2[3*i+2] = random(-100, 100);
    }

    for (i = 0; i < 7; i++) {
      function3[3*i] = (1-0.1*i)*random(10, 15);
      function3[3*i+1] = random(0.02, 0.08);
      function3[3*i+2] = random(-100, 100);
    }

    function1[2] = 5;
    function1[5] = 5;
    function2[0] = 0;
  }
  @Override void draw() {
    push();
    background(75);
    noStroke();

    fill(95);
    ellipse(250, 175, 200, 200);

    for (i = 0; i < 7; i++) {
      fill(60-8*i);
      for (x = -150; x < 650; x = x + 9) {
        float sy1 = heights[i] + (function1[3*i] * sin(function1[3*i+1] * x + function1[3*i+2])) + (function2[3*i] * sin(function2[3*i+1] * x + function2[3*i+2])) + (function3[3*i] * sin(function3[3*i+1] * x + function3[3*i+2]));
        float sy2 = heights[i] + (function1[3*i] * sin(function1[3*i+1] * (x+10) + function1[3*i+2])) + (function2[3*i] * sin(function2[3*i+1] * (x+10) + function2[3*i+2])) + (function3[3*i] * sin(function3[3*i+1] * (x+10) + function3[3*i+2]));

        float y1 = map(sy1 + (0.02+0.02*i)*(250-mouseY), 0, 500, 0, height);
        float y2 = map(sy2 + (0.02+0.02*i)*(250-mouseY), 0, 500, 0, height);
        float y3 = map(500, 0, 500, 0, height);
        float y4 = map(500, 0, 500, 0, height);
        quad(x + (0.02+0.08*i)*(250-mouseX), y1,
          x+10 + (0.02+0.08*i)*(250-mouseX), y2,
          x+10 + (0.02+0.08*i)*(250-mouseX), y3,
          x + (0.02+0.08*i)*(250-mouseX), y4);
      }
    }
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
