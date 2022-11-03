// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】 Skyeさん
// 【作品名】Stars
// https://openprocessing.org/sketch/609209
//

class GameSceneCongratulations385 extends GameSceneCongratulationsBase {
  float opacity = 255;
  star[] stars = new star[400];
  float turn;

  PGraphics pg;

  @Override void setup() {
    background(0);
    fill(120, 232, 255);
    rect(0, 0, width, height);

    for (var i=0; i<stars.length; i++) {
      stars[i] = new star(random(-width, width), random(-height, height), random(1, 4), int(random(3, 9)));
    }

    turn = PI*2/3.0f;

    pg = createGraphics(width, height);
  }
  @Override void draw() {
    push();
    pg.beginDraw();
    pg.noStroke();
    pg.fill(120, 232, 255);
    pg.rect(0, 0, width, height);
    //Night Sky
    for (var i = 0; i<800; i++) {
      opacity-=(255/800.0f);
      pg.stroke(37, 9, 99, opacity);
      pg.line(0, i, width, i);
    }
    opacity = 255;
    for (var i = 550; i>200; i--) {
      opacity-=(255/350.0f);
      pg.stroke(255, 92, 215, opacity);
      pg.line(0, i, width, i);
    }
    opacity = 255;

    //Stars
    pg.fill(255);
    pg.push();
    pg.translate(width/2, height*5/6.0f);
    pg.rotate(turn);
    for (var i=0; i<stars.length; i++) {
      stars[i].display(pg);
    }
    turn+=PI/3000.0f;
    pg.pop();

    //Hills And Trees
    pg.fill(0);
    pg.stroke(0);
    pg.triangle(0, 550, width, 450, width, height);
    for (var i=.25; i<10; i++) {
      drawTree(pg, width-(i*70), 450+(i*10), 60);
    }
    pg.fill(15);
    pg.stroke(15);
    pg.triangle(width, 650, 0, 500, 0, height);
    for (var i=.25; i<10; i++) {
      drawTree(pg, 0+(i*70), 500+(i*15), 80);
    }
    pg.fill(25);
    pg.stroke(25);
    pg.triangle(0, height, width, 550, width, height);
    for (var i=.25; i<10; i++) {
      drawTree(pg, width-(i*70), 550+(i*15), 100);
    }
    pg.noStroke();

    //Moon
    pg.fill(255);
    pg.push();

    pg.beginShape();
    pg.vertex(200, 100);
    pg.bezierVertex(120, 100, 120, 200, 200, 200);
    pg.bezierVertex(160, 200, 160, 100, 200, 100);
    pg.endShape();
    pg.pop();
    pg.endDraw();
    image(pg, 0, 0);
    pop();

    logoRightLower(#ff0000);
  }

  //------ FUNCTIONS ----------------------------------------------------------------------------------------------------------------
  class star {
    float x, y;
    float radius;
    int points;
    float w;

    star(float x, float y, float r, int p) {
      this.x = x;
      this.y = y;
      this.radius = r;
      this.points = p;
      this.w = this.radius/13.0f*this.points;
    }

    void display(PGraphics pg) {
      pg.noStroke();
      pg.push();
      pg.translate(this.x, this.y);
      for (var i=0; i<this.points; i++) {
        pg.rotate(radians(360/this.points));
        pg.triangle(0, 0, this.w, this.radius/2+1, -this.w, this.radius/2+1);
        pg.triangle(0, this.radius, this.w, this.radius/2, -this.w, this.radius/2);
      }
      pg.pop();
    }
  }

  void drawTree(PGraphics pg, float x, float y, float h) {
    var t = 1; //toggle
    pg.push();
    pg.strokeWeight(3);
    pg.translate(x, y-h);
    pg.line(0, 0, 0, h);
    for (var loopTwice=0; loopTwice<2; loopTwice++) {
      for (var i=0; i<7; i++) {
        pg.line(0, (i*h/8.0f), t*((h/20.0f)+(h/33.33*i)), (i*h/8.0f)+(h/40.0f)+(h/33.33/2.0f*i));
      }
      t*=-1;
    }
    pg.pop();
  }
  @Override void mousePressed() {
    gGameStack.change(new GameSceneTitle());
  }
  @Override void keyPressed() {
    super.keyPressed();

    gGameStack.change(new GameSceneTitle());
  }
}
