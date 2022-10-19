// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】Okazzさん
// 【作品名】Super grid 220523
// https://neort.io/art/ca5n95c3p9fbkmo5r8kg
//

class GameSceneCongratulations352 extends GameSceneCongratulationsBase {
  ArrayList<Form> forms = new ArrayList();
  color[] colors = {#e6302b, #fd7800, #fbd400, #51b72d, #2abde4, #5534eb, #f477c3};

  @Override void setup() {
    strokeCap(PROJECT);
    INIT();
  }
  @Override void draw() {
    push();
    background(0);
    for (Form i : forms) {
      i.show();
      i.move();
    }
    if (frameCount % 180 == 0) INIT();
    pop();

    logoRightLower(#ff0000);
  }

  void INIT() {
    float c = 10;
    float w = width / c;
    forms = new ArrayList();
    strokeWeight(width / 50.0f);
    for (var i = 0; i < c; i++) {
      for (var j = 0; j < c + 5; j++) {
        var x = i * w + w / 2;
        var y = j * w + w / 2;
        forms.add(new Form(x, y, w));
      }
    }
    colors = P5JS.shuffle(colors);
  }

  float easeInOutCubic(float x) {
    return x < 0.5 ? 4 * x * x * x : 1 - pow(-2 * x + 2, 3) / 2.0f;
  }

  class Form {
    float x, y, w;
    float[] l;
    int[] l0, l1;
    float t, t1, t2, t3;
    float a, a0, a1;
    float sw0, sw1, sw;
    color col0, col1, col;
    Form(float x, float y, float w) {
      this.x = x;
      this.y = y;
      this.w = w;
      this.l = new float[4];
      this.l0 = new int[4];
      this.l1 = new int[4];
      for (int i = 0; i < 4; i++) {
        this.l0[i] = 1;
        this.l[i] = 1.0f;
        this.l1[i] = int(random(3) * random(1));
      }
      this.t = 0;
      this.t1 = 40;
      this.t2 = this.t1 + 60;
      this.t3 = this.t2 + 40;
      this.a = 0;
      this.a0 = 0;
      this.a1 = HALF_PI * int(random(-1, 1) * 4);
      this.sw0 = width / 400.0f;
      this.sw1 = width / 40.0f;
      this.sw = this.sw0;
      this.col0 = color(#ffffff);
      this.col1 = color(P5JS.random(colors));
      this.col = this.col0;
    }

    void show() {
      push();
      translate(this.x, this.y);
      rotate(this.a);
      strokeWeight(this.sw);
      stroke(this.col);
      line(0, -(this.w / 2) * this.l[0], 0, (this.w / 2) * this.l[1]);
      line(-(this.w / 2) * this.l[2], 0, (this.w / 2) * this.l[3], 0);
      pop();
    }

    void move() {
      if (0 < this.t && this.t < this.t1) {
        var amt = norm(this.t, 0, this.t1 - 1);
        for (var i = 0; i < 4; i++) {
          this.l[i] = lerp(this.l0[i], this.l1[i], easeInOutCubic(amt));
        }
        this.a = lerp(this.a0, this.a1, easeInOutCubic(amt));
        this.sw = lerp(this.sw0, this.sw1, easeInOutCubic(amt));
        this.col = lerpColor(this.col0, this.col1, easeInOutCubic(amt));
      }
      if (this.t2 < this.t && this.t < this.t3) {
        var amt = norm(this.t, this.t2, this.t3 - 1);
        for (var i = 0; i < 4; i++) {
          this.l[i] = lerp(this.l1[i], this.l0[i], easeInOutCubic(amt));
        }
        this.a = lerp(this.a1, this.a0, easeInOutCubic(amt));
        this.sw = lerp(this.sw1, this.sw0, easeInOutCubic(amt));
        this.col = lerpColor(this.col1, this.col0, easeInOutCubic(amt));
      }
      this.t++;
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
