// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】sayoさん
// 【作品名】Shaved Ice
// https://openprocessing.org/sketch/921087
//

class GameSceneCongratulations347 extends GameSceneCongratulationsBase {
  color[] cols = {#FFE296, #9FFF9A, #92E8FF, #C976FF, #FF92D9};

  float upper = 600;
  float bottom = 400;
  float depth = 100;
  float offset = 50;

  float[] h;
  float N = 100;

  KAKIGOURI kaki;
  PGraphics pg;

  class KAKIGOURI {
    void draw(PGraphics pg) {
     pg.text("なにもないとワーニングになるのでいれました＼(^_^)／",0,0);
    }
  }
  class GARIGARI extends KAKIGOURI {
    void draw(PGraphics pg) {
      int n;
      float angle;
      pg.stroke(255);
      for (var i=0; i<N; i++) {
        n = int(P5JS.randomGaussian(width/2, upper/6));
        angle = random(0, PI);
        if (0 <= n && n < h.length) {
          pg.line(n+10*cos(angle), height-(h[n]+10*sin(angle)), n-10*cos(angle), height-(h[n]-10*sin(angle)));
          h[n] += 1;
          if (h[n] >=height-offset) {
            kaki = new SYRUP();
          }
        }
      }
    }
  }
  class SYRUP extends KAKIGOURI {
    void draw(PGraphics pg) {
      int n;
      float angle;
      pg.stroke(#F73576);
      for (var i=0; i<N; i++) {
        n = int(P5JS.randomGaussian(width/2, upper/12)/2)*2;
        angle = random(0, PI);
        pg.line(n+10*cos(angle), height-(h[n]+10*sin(angle)), n-10*cos(angle), height-(h[n]-10*sin(angle)));
        h[n] -= 2;
        if (h[width/2] <= height/2) {
          kaki = new DEKIAGARI();
        }
      }
    }
  }
  class DEKIAGARI extends KAKIGOURI {
    void draw(PGraphics pg) {
      ;  // くらえ＼(^_^)／
    }
  }

  @Override void setup() {
    h = new float[width];
    pg = createGraphics(width, height);
    pg.beginDraw();
    pg.background(cols[int(random(cols.length))]);
    pg.endDraw();

    for (var i=0; i<width; i++) {
      if (i<width/2-(upper+bottom)/4 || i>width/2+(upper+bottom)/4) {
        h[i] = offset;
      } else {
        h[i] = offset+depth-10;
      }
    }

    kaki = new GARIGARI();
  }
  @Override void draw() {
    push();
    pg.beginDraw();
    pg.stroke(255);
    pg.strokeWeight(0.5);

    kaki.draw(pg);

    pg.noStroke();
    pg.fill(240);
    pg.quad(width/2-bottom/2, height-offset, width/2+bottom/2, height-offset,
      width/2+upper/2, height-(offset+depth), width/2-upper/2, height-(offset+depth));
    pg.endDraw();
    image(pg, 0, 0);
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
