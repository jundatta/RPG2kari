// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】Bárbara Almeidaさん
// 【作品名】Twilight
// https://openprocessing.org/sketch/184276
//

class GameSceneCongratulations355 extends GameSceneCongratulationsBase {
  PGraphics bg;

  color treeColor = color(41, 25, 3);
  color bgColor = color(255, 178, 187);
  color lightColor = color(255, 213, 147);
  color darkColor = color(70, 83, 117);
  /*------------------------*/

  PGraphics screen;
  final int CYCLE = (int)(2.5 * 1000);  // [ms]
  int lastMSec;

  @Override void setup() {
    screen = createGraphics(width, height);
    bg = createGraphics(width, height);

    lastMSec = millis();

    drawScreen(screen);
  }

  class Ease {
    float ease(float t) {
      return t;
    }
    Ease next() {
      return new Ease();
    }
  }
  class UpEase extends Ease {
    float ease(float t) {
      return easeInQuart(t);
    }
    Ease next() {
      return new BetweenEase();
    }
  }
  class BetweenEase extends Ease {
    float ease(float t) {
      return 1.0f;
    }
    Ease next() {
      return new DownEase();
    }
  }
  class DownEase extends Ease {
    float ease(float t) {
      return 1.0f - easeOutQuart(t);
    }
    Ease next() {
      drawScreen(screen);
      return new UpEase();
    }
  }
  Ease ease = new UpEase();
  /*------------------------*/
  @Override void draw() {
    push();
    int mSec = millis();
    if (lastMSec + CYCLE < mSec) {
      lastMSec = mSec;
      ease = ease.next();
    }
    float t = map(mSec - lastMSec, 0, CYCLE, 0, 1.0);
    float r = ease.ease(t);
    background(0);
    tint(255, 255 * r);
    image(screen, 0, 0, width, height);
    pop();

    logoRightLower(#ff0000);
  }

  void drawScreen(PGraphics pg) {
    pg.beginDraw();
    noiseSeed((long)random(0xFFFFFF));  //change noiseSeed
    generateSky(bg);  //generate new clouds

    pg.tint(255);
    pg.image(bg, 0, 0);

    //draw tree
    for (int i = 0; i < 5; i++)
    {
      pg.tint(255, 30);
      pg.image(bg, 0, 0);
      tree(pg, width/2, height, height/5, -HALF_PI);
    }

    //draw the ground
    pg.fill(treeColor);
    pg.noStroke();
    pg.rect(0, height - 20, width, 20);
    pg.endDraw();
  }

  /*------------------------*/
  void tree(PGraphics pg, float beginX, float beginY, float bLength, float angle)
  {
    //find the end of the branch
    float endX = beginX + bLength*cos(angle);
    float endY = beginY + bLength*sin(angle);

    //draw the branch
    pg.strokeWeight(map(bLength, height/4, 3, 20, 1));
    pg.stroke(treeColor);
    pg.line(beginX, beginY, endX, endY);

    //generate 2 new branchs
    if (bLength  > 3)
    {
      if (random(1) > 0.1) tree(pg, endX, endY, bLength*random(0.6, 0.8), angle - random(PI/15, PI/5));
      if (random(1) > 0.1) tree(pg, endX, endY, bLength*random(0.6, 0.8), angle + random(PI/15, PI/5));
    }
  }

  /*------------------------*/
  void generateSky(PGraphics pg)
  {
    pg.beginDraw();

    pg.background(bgColor);

    for (int y = 0; y < height; y += 2)
    {
      for (int x = 0; x < width; x += 2)
      {
        //draw clouds
        float n = noise(x/200., y/50.);
        pg.noStroke();
        pg.fill(darkColor, n*map(y, 0, 2*height/3., 255, 0));
        pg.ellipse(x, y, 3, 3);
      }

      //draw the light on the bottom
      strokeWeight(3);
      pg.stroke(lightColor, map(y, 2*height/3, height, 0, 255));
      pg.line(0, y, width, y);
    }

    pg.endDraw();
  }
  @Override void mousePressed() {
    gGameStack.change(new GameSceneTitle());
  }
  @Override void keyPressed() {
    super.keyPressed();

    gGameStack.change(new GameSceneTitle());
  }
}
