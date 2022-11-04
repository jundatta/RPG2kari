// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】独楽回しeddyさん
// 【作品名】CircleHistograms
// https://neort.io/art/c98oaqc3p9f0i94dl3rg
//

class GameSceneCongratulations390 extends GameSceneCongratulationsBase {
  Histogram[] hs = new Histogram[2];

  @Override void setup() {
    background(0);
    colorMode(HSB, 360, 100, 100, 100);

    hs[0] = new Histogram(200);
    hs[1] = new Histogram(400);
  }
  @Override void draw() {
    push();
    background(0, 20);

    for (var i = 0; i < hs.length; i++) {
      hs[i].update();
      hs[i].display();
    }
    pop();

    logoRightLower(#ff0000);
  }

  class Histogram {
    ExpansionLine[] eLines;
    float angle;
    float aVel;

    Histogram(float r)
    {
      this.eLines = new ExpansionLine[180];
      this.angle = random(TWO_PI);
      this.aVel = random(-0.01, 0.01);

      var nSeed = random(10000);

      for (var i = 0; i < eLines.length; i++) {
        var theta = TWO_PI / 180.0f * i;
        var x = r * cos(theta);
        var y = r * sin(theta);
        var c = color(i * 2, 100, 100, 100);
        this.eLines[i] = new ExpansionLine(x, y, nSeed + i, c, r * 0.6);
      }
    }

    void update()
    {
      this.angle += this.aVel;
      for (var i = 0; i < this.eLines.length; i++) {
        this.eLines[i].update();
      }
    }

    void display()
    {
      push();
      translate(width/2, height/2);
      rotate(this.angle);
      for (var i = 0; i < this.eLines.length; i++) {
        this.eLines[i].display();
      }
      pop();
    }
  }

  class ExpansionLine {
    PVector pos1, dir, pos2;
    float seed;
    color col;
    float maxLength, len;

    ExpansionLine(float x, float y, float seed, color col, float len)
    {
      this.pos1 = new PVector(x, y);
      this.dir = PVector.sub(new PVector(0, 0), this.pos1).normalize();
      this.pos2 = PVector.add(this.pos1, this.dir);
      this.seed = seed;
      this.col = col;
      this.maxLength = len;
      this.len = len;
    }

    void update() {
      this.seed += 0.01;
      this.len = map(noise(this.seed), 0, 1, 0, this.maxLength);
      this.pos2 = PVector.add(this.pos1, this.dir.copy().mult(this.len));
    }

    void display() {
      push();
      noFill();
      stroke(this.col);
      strokeWeight(5);
      strokeCap(SQUARE);
      line(this.pos1.x, this.pos1.y, this.pos2.x, this.pos2.y);
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
