// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】Che-Yu Wuさん
// 【作品名】200421 Energetic Bamboo
// https://openprocessing.org/sketch/878972
//

class GameSceneCongratulations344 extends GameSceneCongratulationsBase {
  PGraphics pg;

  color[] colors = {#cdf2ba, #77af5b, #76a855, #c4e878, #e8f78a, #dded63, #f1f4e6};
  class Particle {
    PVector p, v, a;
    float r, w;
    color col;
    boolean child;
    PVector lastP;
    boolean dead;

    Particle(PVector p, PVector v, float r, float w, color col) {
      this.p = p;
      this.v = v;
      a = new PVector(0, 0);
      this.r = r;
      this.w = w;
      this.col = col;
      child = false;
      lastP = new PVector(0, 0);
      dead = false;
    }
    void draw(PGraphics pg) {
      pg.push();
      pg.translate(this.p.x, this.p.y);
      pg.rotate(this.v.heading()-PI*1.5);
      pg.fill(this.col);
      pg.rect(0, 0, this.r, this.v.y);
      pg.rectMode(CENTER);
      pg.rect(this.r/2.0f, this.v.y, this.r+2, 2);
      pg.rect(this.r/2.0f, 0, this.r+2, 2);
      if (random(1)>0.7) {
        var count = int(random(2, 4));
        for (var i=0; i<count; i++) {
          pg.push();
          pg.rotate((i*2-1)/1.2* this.v.heading()/(float)(1+random(2))*random(-1, 1)+PI*0.5 );
          pg.fill(P5JS.random(colors));
          // ※なぜかわかりゃん＼(^_^)／がこれでなんかいい感じになった。
          // １．curveVertex()とvertex()が混ざっていたらすべてcurveVertex()に変える
          // ２．最初と最後のcurveVertex()は2回連続で呼ぶように変える
          pg.beginShape();
          var ww = this.v.y+random(-5, 5);
          pg.curveVertex(0, 0);
          pg.curveVertex(0, 0);
          pg.curveVertex(ww/2.0f, 5);
          pg.curveVertex(ww, 0);
          pg.curveVertex(ww/2.0f, -5);
          pg.curveVertex(ww/2.0f, -5);
          pg.endShape(CLOSE);
          pg.pop();
        }
      }

      for (var o=0; o<this.r; o+=1) {
        color c = color(P5JS.random(colors));
        //c.setAlpha(random(80));
        c = color(red(c), green(c), blue(c), random(80));
        pg.stroke(c);
        pg.line(o, 0, o, this.v.y/random(1.5, 2.5));
      }

      pg.pop();
    }
    void update() {
      this.lastP=this.p.copy();
      this.p.add(this.v);
      this.v.add(this.a);
      this.v.mult(0.99);
      if (this.p.y<-50) {
        this.dead=true;
      }
      if (this.child) {
        this.r-=4;
        if (this.r<1) {
          this.dead=true;
        }
      }
    }
  }

  ArrayList<Particle> particles = new ArrayList();

  @Override void setup() {
    pg = createGraphics(width, height);
    pg.beginDraw();
    pg.background(50);
    pg.fill(#222222);
    pg.noStroke();
    pg.rect(0, 0, width, height);
    pg.endDraw();

    // ※drawingContextは超えられない壁＼(^_^)／
    //  drawingContext.shadowColor = color(30, 70, 80, 235);
    //drawingContext.shadowBlur =30;
    for (var i=0; i<50; i++)  generateNewBamboo();
  }

  void generateNewBamboo() {
    var p = new Particle( new PVector(random(width), height +random(50, 100)),
      //new PVector(random(-6, 6), random(-30, -100)),
      // ※p5.js(JavaScript)はrandom()の引数が大きい、小さいの順でもいい感じの値を返すように見える
      // ※Processing javaは大きい、小さいの順ではいい感じの値を返さない
      new PVector(random(-6, 6), random(-100, -30)),
      random(8, 18), random(20, 30), P5JS.random(colors));
    if (random(1)<0.1) {
      p.v.mult(0.5);
      p.r*=3;
      p.child=true;
      p.col = color(#e5c677);
    }
    particles.add(p);
  }

  @Override void draw() {
    push();
    pg.beginDraw();
    for (Particle p : particles) {
      p.update();
      p.draw(pg);
    }
    ArrayList<Particle> newPs = new ArrayList();
    for (Particle p : particles) {
      if (p.dead) {
        continue;
      }
      newPs.add(p);
    }
    particles = newPs;
    if (frameCount%20 == 0) {
      pg.fill(0, 1);
      pg.rect(0, 0, width, height);
      for (var i=0; i<2; i++) generateNewBamboo();
    }
    // ※drawingContextは超えられない壁＼(^_^)／
    // （。。。私ごときでは太刀打ちできません...orz）
    pg.filter(BLUR, 1);
    pg.endDraw();
    image(pg, 0, 0);
    pop();

    logoRightLower(#ff0000);
  }
  @Override void mousePressed() {
    for (var i=0; i<5; i++) generateNewBamboo();
  }
  @Override void keyPressed() {
    super.keyPressed();

    gGameStack.change(new GameSceneTitle());
  }
}
