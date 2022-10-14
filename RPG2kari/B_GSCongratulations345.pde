// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】Okazzさん
// 【作品名】PPPP
// https://neort.io/art/c8pk8sc3p9f0i94dgpcg
//

class GameSceneCongratulations345 extends GameSceneCongratulationsBase {
  ArrayList<Balloon> balloons = new ArrayList();
  color[] colors = {#000000, #ED4141, #2B8BDF, #159670, #ffffff};
  float bsSize;

  @Override void setup() {
    bsSize = (width * height) / 900.0f;
    for (int i = 0; i < 132; i++) {
      balloons.add(new Balloon());
    }
  }
  @Override void draw() {
    push();
    background(#FECA16);
    noStroke();
    fill(255);
    for (Balloon b : balloons) {
      b.run();
    }
    for (int i = 0; i < balloons.size(); i++) {
      Balloon b = balloons.get(i);
      if (b.isDead) {
        balloons.remove(i);
        balloons.add(new Balloon());
      }
    }
    pop();

    logoRightLower(#ff0000);
  }

  class Balloon {
    float x0, x1, x, y0, y1, y;
    float d;
    int t, t1, t2;
    ArrayList<Pop> pops;
    boolean isDead;
    color col;

    Balloon() {
      this.x0 = random(width);
      this.x1 = random(width);
      this.x = this.x0;
      this.y0 = -height * 0.4;
      this.y1 = random(height);
      this.y = this.y0;
      this.d = random(random(random(random(bsSize * 0.4)))) + bsSize * 0.01;
      this.t = -int(random(200));
      this.t1 = int(random(100, 200));
      this.t2 = this.t1 + 60;
      this.pops = new ArrayList();
      int pn = int(random(10, 20));
      for (int i = 0; i < pn; i++) {
        this.pops.add(new Pop(this.x1, this.y1, this.d));
      }
      this.isDead = false;
      this.col = P5JS.random(colors);
    }

    void show() {
      if (this.t < this.t1) {
        fill(this.col);
        noStroke();
        circle(this.x, this.y, this.d);
      } else if (this.t < this.t2) {
        for (Pop p : this.pops) {
          p.show(this.col);
          p.move();
        }
      }
    }

    void move() {
      if (0 < this.t && this.t < this.t1) {
        var amt = norm(this.t, 0, this.t1 - 1);
        this.x = lerp(this.x0, this.x1, pow(amt, 0.3f));
        this.y = lerp(this.y0, this.y1, pow(amt, 0.3f));
      }
      this.t++;
      if (this.t > this.t2) {
        this.isDead = true;
      }
    }

    void run() {
      this.show();
      this.move();
    }
  }

  class Pop {
    float x, y, d0, d;
    int n;
    float r, tr;
    int t, t1;
    float a;

    Pop(float x, float y, float d) {
      this.x = x;
      this.y = y;
      this.d0 = d * random(0.1, 0.5);
      this.d = this.d0;
      this.n = int(random(10));
      this.r = 0;
      this.tr = d * random(0.1, 2);
      this.t = 0;
      this.t1 = int(random(1, 50));
      this.a = random(TAU);
    }

    void show(color col) {
      if (this.t < this.t1) {
        fill(col);
        noStroke();
        circle(this.x + this.r * cos(this.a), this.y + this.r * sin(this.a), this.d);
      }
    }

    void move() {
      if (this.t < this.t1) {
        var amt = norm(this.t, 0, this.t1 - 1);
        this.d = lerp(this.d0, 0, pow(amt, 0.5f));
        this.r = lerp(0, this.tr, pow(amt, 0.5f));
        this.t++;
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
