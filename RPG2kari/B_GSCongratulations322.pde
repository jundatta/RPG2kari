// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】Ivan Rudnickiさん
// 【作品名】Photo Fragments
// https://openprocessing.org/sketch/973470
//

class GameSceneCongratulations322 extends GameSceneCongratulationsBase {
  PImage img;
  ArrayList<Pixel> drips = new ArrayList();
  float interval;
  int counter = 0;

  void preload() {
    img = loadImage("data/322/IMG_0103.JPG");
  }

  @Override void setup() {
    preload();

    img.resize(width, height);
    interval = img.height / 50.0f;
    //angleMode(DEGREES);
    noStroke();
    for (float y = interval / 2; y <= img.height; y += interval) {
      for (float x = interval / 2; x <= img.width; x += interval) {
        color c = img.get((int)x, (int)y);
        int a = (int)alpha(c);
        int r = (int)red(c);
        int g = (int)green(c);
        int b = (int)blue(c);
        a = 200;
        int id = r + g + b;
        if (id > 0) {
          c = color(r, g, b, a);
          drips.add(new Pixel(x, y, c, id));
        }
      }
    }
  }
  @Override void draw() {
    push();
    counter += 2;
    background(0);
    for (Pixel d : drips) {
      if (d.id < counter) {
        d.move();
        if (d.y > 0) {
          d.show();
        }
      }
    }
    pop();

    logoRightLower(#ff0000);
  }
  class Pixel {
    float x, y;
    float yvel;
    float basex, basey;
    color c;
    int id;
    boolean falling;

    Pixel(float x, float y, color c, int id) {
      this.x = x;
      this.y = -300;
      this.yvel = 0;
      this.basex = x;
      this.basey = y;
      this.c = c;
      this.id = id;
      this.falling = true;
    }
    void move() {
      final int offset = 100; // 適当な値にゃ＼(^_^)／
      this.y += this.yvel;
      if (this.y < this.basey) {
        this.yvel += 0.5;
      } else {
        this.y -= this.yvel;
        this.yvel *= -0.3;
        // マウスの位置が画面範囲外なら何もしない
        if (mouseX < offset || width-offset < mouseX
          || mouseY < offset || height-offset < mouseY) {
          return;
        }
        float d = dist(this.x, this.y, mouseX, mouseY);
        if (d < 100) {
          this.yvel -= 1000 / (float)(d + 10);
        }
      }
    }
    void show() {
      push();
      fill(this.c);
      translate(this.x, this.y);
      rotate(radians(this.y-this.basey));
      rect(0, 0, 1.1*interval, 1.1*interval);
      pop();
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
