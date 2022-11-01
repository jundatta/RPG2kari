// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】Jenni Hutsonさん
// 【作品名】4b
// https://openprocessing.org/sketch/838061
//

class GameSceneCongratulations381 extends GameSceneCongratulationsBase {
  PGraphics pg;
  //int OrgW = 800;
  //int OrgH = 450;
  @Override void setup() {
    //pg = createGraphics(OrgW, OrgH);
    pg = createGraphics(width, height);
    pg.beginDraw();
    pg.background(255);
    float ii = 0;
    for (int y = 0; y<=450; y+=1) {
      pg.stroke(13+ii, 2+ii, 52+ii);
      pg.line(0, y, 800, y);
      ii+=.25;
    }
    pg.stroke(220, 176, 51, 100);
    for (int i = 0; i<1000; i+=1) {
      pg.point(random(800), random(410));
    }
    pg.stroke(255, 255, 255, 100);
    for (int i = 0; i<1000; i+=1) {
      pg.point(random(800), random(410));
    }
    pg.fill(0);
    pg.strokeWeight(1);
    pg.stroke(0);
    pg.rect(350, 370, 100, 40, 7);
    pg.triangle(350, 373, 450, 373, 400, 340);
    pg.noStroke();
    pg.fill(233, 182, 37);
    pg.triangle(365, 405, 435, 405, 400, 370);
    pg.stroke(0);
    pg.strokeWeight(1);
    pg.line(300, 410, 350, 373);
    pg.line(450, 373, 500, 410);

    pg.noStroke();
    pg.fill(0);
    pg.rect(0, 410, 800, 450);
    pg.stroke(0);
    for (int i = 0; i<5000; i+=1) {
      float x = random(800);
      float y = 405 - 2*randomGaussian();
      pg.line(x, y, x, 420);
    }
    float x1 = 60;
    float y1 = 100;
    float x2 = 300;
    float y2 = 55;
    for (int i = 0; i <6; i+=1) {
      pg.strokeWeight(1);
      pg.stroke(255, 255, 255, 200);
      if (y2 > 35) {
        x1 += 60;
        x2 += 60;
        y1 -= 40;
        y2 -= 40;
      } else {
        x1+= 80;
        x2+= 80;
        y1 += 100;
        y2 += 100;
      }
      pg.line(x1, y1, x2, y2);
      pg.strokeWeight(3);
      pg.stroke(255);
      pg.point(x1, y1);
    }
    pg.endDraw();
  }
  @Override void draw() {
    push();
    image(pg, 0, 0, width, height);
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
