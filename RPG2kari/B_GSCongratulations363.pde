// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】Junichiro Horikawaさん
// 【作品名】20200414_omniscient
// https://openprocessing.org/sketch/873283
//

class GameSceneCongratulations363 extends GameSceneCongratulationsBase {
  float charSize = 50;
  int buildingNum = 50;
  Building[] buildings = new Building[buildingNum];
  float minHeight = 50;
  float maxHeight = 250;
  float minWidth = 10;
  float maxWidth = 20;
  float growspeed = 0.4;
  float jumpHeight = 20.0;
  float earthSpeed = 0.3;
  float dayval = 0.0;
  PGraphics moonpg;
  int moonsize = 125;

  PGraphics maskpg;
  PGraphics pg;
  final int OrgW = 840;
  final int OrgH = 370;

  class ColorPaletteClass {
    color dark = #364f6b;
    color blue = #3fc1c9;
    color white = #f5f5f5;
    color red = #fc5185;
  }
  ColorPaletteClass ColorPalette = new ColorPaletteClass();

  @Override void setup() {
    pg = createGraphics(OrgW, OrgH);
    pg.beginDraw();
    pg.noStroke();
    pg.endDraw();

    for (var i=0; i<buildingNum; i++) {
      var building = new Building(i, TWO_PI * random(1), random(minHeight, maxHeight), random(minWidth, maxWidth));
      buildings[i] = building;
    }

    moonpg = createGraphics(moonsize, moonsize);
    moonpg.beginDraw();
    moonpg.noStroke();
    moonpg.fill(ColorPalette.white);
    moonpg.ellipse(moonsize * 0.5, moonsize * 0.5, moonsize, moonsize);
    //moonpg.erase();
    //moonpg.ellipse(moonsize * 0.375, moonsize * 0.375, moonsize * 0.75, moonsize * 0.75);
    //moonpg.noErase();
    moonpg.endDraw();

    maskpg = createGraphics(moonsize, moonsize);
    maskpg.beginDraw();
    maskpg.background(0);
    maskpg.noStroke();
    maskpg.fill(255);
    maskpg.ellipse(moonsize * 0.5, moonsize * 0.5, moonsize, moonsize);
    maskpg.fill(0);
    maskpg.ellipse(moonsize * 0.375, moonsize * 0.375, moonsize * 0.75, moonsize * 0.75);
    maskpg.endDraw();
    moonpg.mask(maskpg);
  }
  @Override void draw() {
    push();
    pg.beginDraw();
    var dayval = map(sin(radians(frameCount * 1.0)), -1.0, 1.0, 0.0, 1.0);

    pg.background(lerpColor(color(ColorPalette.dark), color(ColorPalette.blue), dayval));//map(dayval, 0.0, 1.0, 0.0, 255));
    pg.fill(ColorPalette.red);
    pg.ellipse(moonsize + 50, -(moonsize + 50) + dayval * (moonsize + 50) * 2, moonsize, moonsize);
    pg.image(moonpg, pg.width - (moonsize * 1.5 + 50), (moonsize * 0.5 + 50) - dayval * (moonsize + 50) * 2);

    pg.fill(map(dayval, 0.0, 1.0, 255, 0));
    pg.push();
    pg.translate(pg.width * 0.5, pg.height);
    for (var i=0; i<buildings.length; i++) {
      var building = buildings[i];
      building.update();
      building.draw(pg, dayval);
    }
    pg.fill(lerpColor(color(ColorPalette.white), color(ColorPalette.red), dayval));//map(dayval, 0.0, 1.0,255, 0));
    pg.ellipse(0, 0, pg.height, pg.height);
    pg.pop();

    pg.fill(lerpColor(color(ColorPalette.white), color(ColorPalette.red), dayval));// fill(map(dayval, 0.0, 1.0,255, 0));
    pg.ellipse(pg.width * 0.5, pg.height * 0.5 - charSize * 0.5 - jumpHeight * abs(sin(radians(frameCount * 5))), charSize, charSize);
    pg.endDraw();
    image(pg, 0, 0, width, height);
    pop();

    logoRightLower(#ff0000);
  }

  class Building {
    float id;
    float posang;
    float hh, ww;
    boolean isNew, hasWindow;
    float widthang;

    Building(float id, float posang, float hh, float ww) {
      this.id = id;
      this.posang = posang;
      this.hh = hh;
      this.ww = ww;
      this.isNew = false;

      var rnd = random(1);
      if (rnd < 0.5) {
        this.hasWindow = true;
      } else {
        this.hasWindow = false;
      }
      this.widthang = 2 * asin(ww / (2 * hh));
    }

    void update() {
      if (sin(this.posang) > 0.5 && this.isNew == true) {
        var rndang = radians(random(45.0, 135.0));
        this.posang = rndang;
        this.hh = random(minHeight, maxHeight);
        this.ww = random(minWidth, maxWidth);
        this.isNew = false;

        var rnd = random(1);
        if (rnd < 0.5) {
          this.hasWindow = true;
        } else {
          this.hasWindow = false;
        }
      } else if (sin(this.posang) < -0.5 && this.isNew == false) {
        this.isNew = true;
      }

      this.posang -= radians(earthSpeed);
      if (this.posang < 0.0) {
        this.posang += TWO_PI;
      }
    }

    void draw(PGraphics pg, float dayval) {
      // heightとthis.heightはheight（グローバル変数）が優先された。
      var hhalf = /* hh */ pg.height * 0.5;
      var h = hhalf;
      if (this.posang >PI && this.posang < TWO_PI) {
        h += this.hh * min(sin(this.posang - PI), growspeed) / growspeed;
      }
      var a1 = this.posang - this.widthang * 0.5;
      var a2 = this.posang + this.widthang * 0.5;
      var p1 = new PVector(cos(a1) *h, sin(a1) * h);
      var p2 = new PVector(cos(a2) * h, sin(a2) * h);
      var p3 = new PVector(cos(a2) * hhalf, sin(a2) * hhalf);
      var p4 = new PVector(cos(a1) * hhalf, sin(a1) * hhalf);

      var col1 = lerpColor(color(ColorPalette.dark), color(ColorPalette.white), this.id / (float)buildingNum);
      var col2 = lerpColor(color(ColorPalette.red), color(ColorPalette.white), 1.0 - this.id / (float)buildingNum);
      var fillcol = lerpColor(col1, col2, dayval);

      pg.fill(fillcol);
      pg.beginShape();
      pg.vertex(0, 0);
      pg.vertex(p1.x, p1.y);
      pg.vertex(p2.x, p2.y);
      pg.endShape(CLOSE);

      if (this.hasWindow) {
        var cp = PVector.mult(PVector.add(PVector.add(PVector.add(p1, p2), p3), p4), 0.25);
        var wp1 = PVector.add(PVector.mult(PVector.sub(p1, cp), 0.25), cp);
        var wp2 = PVector.add(PVector.mult(PVector.sub(p2, cp), 0.25), cp);
        var wp3 = PVector.add(PVector.mult(PVector.sub(p3, cp), 0.25), cp);
        var wp4 = PVector.add(PVector.mult(PVector.sub(p4, cp), 0.25), cp);
        pg.fill(ColorPalette.white);
        pg.beginShape();
        pg.vertex(wp1.x, wp1.y);
        pg.vertex(wp2.x, wp2.y);
        pg.vertex(wp3.x, wp3.y);
        pg.vertex(wp4.x, wp4.y);
        pg.endShape(CLOSE);
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
