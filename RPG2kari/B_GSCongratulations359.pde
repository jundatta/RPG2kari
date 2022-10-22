// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】reona396さん
// 【作品名】Fruits
// https://openprocessing.org/sketch/197387
//

class GameSceneCongratulations359 extends GameSceneCongratulationsBase {
  Fruits[] fruits = new Fruits[10];

  int[] hue = {
    10, 40, 60, 90
  };

  @Override void setup() {
    colorMode(HSB, 360, 100, 100);
    background(360);
    noStroke();

    for (int i = 0; i < fruits.length; i++) {
      fruits[i] = new Fruits(random(width), random(height), hue[(int)random(4)], random(0.5, 1.0));
    }
  }
  @Override void draw() {
    push();
    background(360);

    for (int i = 0; i < fruits.length; i++) {
      fruits[i].display();
      fruits[i].move();
    }
    pop();

    logoRightLower(#ff0000);
  }

  class Fruits {
    float x;
    float y;
    int hue;
    float S;

    float theta = random(TWO_PI);
    float theta_spd;

    float spd = random(0.3, 1.0);
    float x_spd = 0;
    float y_spd = 0;

    Fruits(float tmpX, float tmpY, int tmpHue, float tmpS) {
      x = tmpX;
      y = tmpY;
      hue = tmpHue;
      S = tmpS;

      switch((int)random(4)) {
      case 0:
        x_spd = spd;
        theta_spd = spd;
        break;
      case 1:
        x_spd = -spd;
        theta_spd = -spd;
        break;
      case 2:
        y_spd = spd;
        theta_spd = spd;
        break;
      case 3:
        y_spd = -spd;
        theta_spd = -spd;
        break;
      }
    }

    void display() {
      pushMatrix();
      translate(x, y);
      rotate(radians(theta));

      fill(hue, 50, 100);
      ellipse(0, 0, 200*S, 200*S);
      fill(hue, 10, 100);
      ellipse(0, 0, 180*S, 180*S);

      fill(hue, 80, 100);
      for (int i = 0; i < 10; i++) {
        pushMatrix();
        translate(0, 0);
        rotate(radians(360*i/10));

        beginShape();
        vertex(0, -10*S);
        vertex(-20*S, -70*S);
        vertex(20*S, -70*S);
        endShape();
        ellipse(0, -70*S, 40*S, 20*S);
        popMatrix();
      }
      popMatrix();
    }

    void move() {
      x += x_spd;
      y += y_spd;

      theta += theta_spd;

      if (x > width + 100*S) {
        x = -100*S;
      }
      if (x < -100*S) {
        x = width+100*S;
      }
      if (y > height + 100*S) {
        y = -100*S;
      }
      if (y < -100*S) {
        y = height + 100*S;
      }
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
