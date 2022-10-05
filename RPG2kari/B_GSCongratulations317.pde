// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】reona396さん
// 【作品名】curve vertexes
// https://openprocessing.org/sketch/1330664
//

class GameSceneCongratulations317 extends GameSceneCongratulationsBase {
  final int mypointsNum = 500;
  MyPoint[] mypoints = new MyPoint[mypointsNum];
  float maxR;
  final color[] palette = {#ffffff, #000000};

  PGraphics pg, mk;

  @Override void setup() {
    maxR = min(width, height) * 0.5;

    for (var i = 0; i < mypointsNum; i++) {
      mypoints[i] = new MyPoint();
    }

    noStroke();

    pg = createGraphics(width, height);
    mk = createGraphics(width, height);
  }
  @Override void draw() {
    push();
    background(0);

    push();
    colorMode(HSB, 360, 100, 100);
    pg.beginDraw();
    for (int i = 0; i < height; i++) {
      int h = (int)map(i, 0, height, 0, 360);
      color c = color(h, 100, 100);
      pg.stroke(c);
      pg.line(0, i, width-1, i);
    }
    pg.endDraw();
    pop();

    mk.beginDraw();
    mk.background(0);
    for (var j = 0; j < palette.length; j++) {
      mk.fill(palette[j]);
      //if (j == 0) {
      //  let gradientFill = drawingContext.createLinearGradient(
      //    0,
      //    -maxR / 2,
      //    0,
      //    maxR / 2
      //    );

      //  gradientFill.addColorStop(0, color(255, 0, 255));
      //  gradientFill.addColorStop(0.5, color(255, 255, 0));
      //  gradientFill.addColorStop(1, color(0, 255, 255));

      //  drawingContext.fillStyle = gradientFill;
      //}
      mk.push();
      mk.translate(width / 2, height / 2);
      mk.rotate(TWO_PI * j / palette.length);

      mk.beginShape();
      for (var i = 0; i < mypoints.length; i++) {
        mypoints[i].move();
        mk.curveVertex(mypoints[i].x, mypoints[i].y);
      }
      mk.endShape(CLOSE);
      mk.pop();
    }
    mk.endDraw();
    pg.mask(mk);
    image(pg, 0, 0);
    pop();

    logoRightLower(#ff0000);
  }

  class MyPoint {
    float r, t;
    float tSpeed, tSign;
    float d;
    float x, y;
    float nvA;
    float nStep, nSpeed;
    MyPoint() {
      this.r = maxR * sqrt(random(1));
      this.t = random(TAU);
      this.tSpeed = random(0.001, 0.01);
      this.tSign = random(10) < 5 ? -1 : 1;
      this.d = 10;
      this.x = 0;
      this.y = 0;
      this.nvA = random(1000);

      this.nStep = random(1000);
      this.nSpeed = random(0.001, 0.01);
    }

    void move() {
      this.r = maxR * sqrt(lerp(0, 1, noise(this.nStep, this.nvA)));

      this.x = this.r * cos(this.t);
      this.y = this.r * sin(this.t);

      this.nStep += this.nSpeed;
      this.t += this.tSign * this.tSpeed;
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
