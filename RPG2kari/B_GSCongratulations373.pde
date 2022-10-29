// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】Austin Obringerさん
// 【作品名】Flappy Bird
// https://openprocessing.org/sketch/857975
//

class GameSceneCongratulations373 extends GameSceneCongratulationsBase {
  ArrayList<Pillar> pillars = new ArrayList<Pillar>();
  Bird bird;
  float pillarSpacing;
  float spaceSize;
  float wide;
  float g;
  float hop;
  boolean gameOver;
  float worldPos;
  float gameSpeed;
  float endTime;
  float mapHeight;
  float mapBottomSize;
  float pillarTopSize;
  color green;
  float[] bushHeights;
  float[] cloudHeights;
  float cloudOff;
  float bushOff;
  int pipesPassed;

  PGraphics pg;

  @Override void setup() {
    pg = createGraphics(width, height);

    pillarSpacing = 400;
    gameSpeed = 4;
    pillarSpacing = floor(pillarSpacing / gameSpeed);
    pillarSpacing *= gameSpeed;
    spaceSize = 200;
    wide = 100;
    g = (9.8 / (float)frameRate) * 0.5f;
    hop = 5;
    worldPos = -gameSpeed * 10;
    mapHeight = height - 150;

    bird = new Bird();
    green = color(100, 200, 75);
    mapBottomSize = height - mapHeight;
    pillarTopSize = 35;
    bushHeights = new float[(width * 2 + 50 + (50-1)) / 50];
    for (int i = 0; i < bushHeights.length; i++) {
      bushHeights[i] = random(25, 55);
    }
    cloudHeights = new float[(width * 2 + 75 + (75-1)) / 75];
    for (int i = 0; i < cloudHeights.length; i++) {
      cloudHeights[i] = random(25, 55);
    }
  }
  @Override void draw() {
    push();
    pg.beginDraw();
    pg.rectMode(CENTER);

    if (!gameOver) {
      pg.background(100, 175, 225);
      drawBack(pg);
      pg.fill(139, 69, 19);
      pg.rect(width / 2, mapHeight + mapBottomSize / 2, width, mapBottomSize);
      pg.fill(75, 180, 75);
      pg.rect(width / 2, mapHeight + 10, width, 20);

      bird.display(pg);
      bird.update();
      for (int i = 0; i < pillars.size(); i++) {
        pillars.get(i).display(pg);
        pillars.get(i).update();
        pillars.get(i).collision();
        pillars.get(i).isPassed();
        if (pillars.get(i).x < -wide / 2) {
          pillars.remove(i);
          i--;
        }
      }
      pg.fill(255);
      pg.textSize(70);
      pg.textAlign(CENTER);
      pg.text(pipesPassed, width / 2, mapHeight + mapBottomSize * (2 / 3));
      worldPos += gameSpeed;
      if (worldPos % pillarSpacing == 0) {
        pillars.add(new Pillar(width + wide / 2, random(spaceSize / 2 + pillarTopSize, mapHeight - spaceSize / 2 - pillarTopSize)));
      }
      cloudOff += 0.2;
      bushOff += 0.1;
    } else {
      pg.background(100, 175, 225);
      pg.fill(255);
      pg.textAlign(CENTER, CENTER);
      pg.textSize(50);
      pg.text("You passed " + pipesPassed + " pipes!", width / 2, height / 2);
      endTime++;
    }
    pg.endDraw();
    image(pg, 0, 0);
    pop();

    logoRightLower(#ff0000);
  }

  class Bird {
    float x;
    float y;
    float r;
    float yvel;

    Bird() {
      x = 100;
      y = height / 2;
      r = 20;
    }

    void display(PGraphics pg) {
      pg.pushMatrix();
      pg.translate(x, y);
      if (yvel >= 0) {
        pg.rotate(radians(25));
      } else if (yvel < 0) {
        pg.rotate(radians(-25));
      }
      pg.stroke(0);
      pg.strokeWeight(2);
      pg.fill(255, 255, 0);
      pg.ellipse(0, 0, r * 2, r * 2);
      pg.fill(255);
      pg.ellipse(-r * (2 / 3.0f), 0, r * 1.2, r);
      pg.fill(255, 165, 0);
      pg.ellipse(r * 7 / 9.0f, r * (3 / 9.0f), r * 1.2, r / 1.5);
      pg.line(r * 7 / 9.0f - r * 0.6, r * (3 / 9.0f), r * 7 / 9.0f + r * 0.6, r * (3 / 9.0f));
      pg.fill(255);
      pg.ellipse(r * (3 / 5.0f), -r * (1 / 3.0f), r * 0.8, r * 0.8);
      pg.fill(0);
      pg.ellipse(r * 7 / 9.0f, -r * (3 / 9.0f), r / 3.0f, r / 3.0f);
      pg.popMatrix();
    }

    void update() {
      y += yvel;
      yvel += g;
      if (y > mapHeight - r || y < r) {
        gameOver = true;
      }
    }
  }

  class Pillar {
    float x;
    float spaceY;
    float speed;
    float topSize;
    float bottomSize;
    float topEdge;
    float bottomEdge;
    boolean passed;

    Pillar(float x_, float y_) {
      x = x_;
      spaceY = y_;
      speed = gameSpeed;
      topEdge = spaceY - spaceSize / 2;
      bottomEdge = spaceY + spaceSize / 2;
      topSize = topEdge;
      bottomSize = mapHeight - spaceSize - topSize;
    }

    void display(PGraphics pg) {
      pg.fill(green);
      pg.rect(x, topSize / 2, wide, topSize + 2);
      pg.rect(x, spaceY + spaceSize / 2 + bottomSize / 2, wide, bottomSize);
      pg.rect(x, topEdge - pillarTopSize / 2 + 1, wide + 10, pillarTopSize);
      pg.rect(x, bottomEdge + pillarTopSize / 2 - 1, wide + 10, pillarTopSize);
    }

    void update() {
      x -= speed;
    }

    void collision() {
      float bx = bird.x;
      float by = bird.y;
      float br = bird.r;
      if (bx + br > x - wide / 2 && bx - br < x + wide / 2) {
        if (by + br > bottomEdge || by - br < topEdge) {
          gameOver = true;
        }
      }
    }

    void isPassed() {
      if (!passed && x < bird.x) {
        passed = true;
        pipesPassed++;
      }
    }
  }

  @Override void mousePressed() {
    bird.yvel = -hop;
    if (gameOver && endTime > 20) {
      reset();
    }
  }
  @Override void keyPressed() {
    super.keyPressed();

    gGameStack.change(new GameSceneTitle());
  }

  void reset() {
    gameOver = false;
    endTime = 0;
    pillars = new ArrayList<Pillar>();
    bird.y = mapHeight / 2;
    bird.yvel = 0;
    worldPos = -gameSpeed * 10;
    pipesPassed = 0;
  }

  void drawBack(PGraphics pg) {
    for (int i = 0; i < width * 2 + 75; i += 75) {
      pg.fill(255, 220);
      pg.stroke(220);
      float pos = i - cloudOff;
      float loops = floor(cloudOff / width);
      float newPos = pos + (width * loops);
      pg.arc(newPos, mapHeight - 75, 75, cloudHeights[i / 75], radians(-180), 0);
    }
    pg.noStroke();
    pg.fill(255, 220);
    pg.rect(width / 2, mapHeight - 50, width, 50);
    for (int i = 0; i < width * 2 + 50; i += 50) {
      pg.fill(75, 180, 75);
      pg.stroke(50, 150, 50);
      float pos = i - bushOff;
      float loops = floor(bushOff / width);
      float newPos = pos + (width * loops);
      pg.arc(newPos, mapHeight - 25, 50, bushHeights[i / 50], radians(-180), 0);
    }
    pg.noStroke();
    pg.rect(width / 2, mapHeight, width, 50);
    pg.stroke(0);
  }
}
