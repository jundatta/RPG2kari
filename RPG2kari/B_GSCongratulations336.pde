// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】Francisさん
// 【作品名】Night Sky
// https://openprocessing.org/sketch/192695
//

class GameSceneCongratulations336 extends GameSceneCongratulationsBase {
  //stars
  float starsCount = 10000;
  PImage stars;
  float skyRotation = 0;
  float rotationIncrement;
  PGraphics gStars;
  int starsoffset;
  //moon
  float radius = 70;
  float glowOffset = 50;
  float moon_x, moon_y;
  PGraphics gMoon;
  //nebula
  float tx, ty, tz = 0.0f;
  float noiseX = 0.004f;
  float noiseY = 0.001f;
  float noiseZ = 0.00001f;
  //ground
  PGraphics gGround;
  //Tree
  PGraphics gTree;

  @Override void setup() {
    background(0);
    initStars();
    initMoon();
    initGround();
    initTree();
  }

  void initStars() {
    starsoffset = Math.abs(width-height) * 2;
    gStars =  createGraphics(width + starsoffset, height+ starsoffset);
    gStars.beginDraw();
    gStars.background(0);
    //gStars.stroke(255);
    for (int i = 0; i < starsCount; i++) {
      float standardDev  = 120;
      float x = randomGaussian() * standardDev + gStars.width/2 ;
      float y = randomGaussian() * standardDev + (gStars.height/2);
      float size = 1;
      float randomNumber = random(0, 100);
      if (randomNumber <= 50) {
        size = 1.3f;
      } else if (randomNumber <= 98) {
        size = 1.7;
      } else {
        size = 2.4;
      }
      gStars.stroke(size);
      gStars.ellipse(x, y, size, size);
    }
    gStars.endDraw();
  }

  void initMoon() {
    rotationIncrement = lerp(0, TWO_PI, 0.0005); //for the web
    //  rotationIncrement = lerp(0, TWO_PI, 0.0001); //for desktop
    float totalDimension = ( radius + glowOffset ) * 2;
    float totalRadius = radius + glowOffset;
    float vx=0, vy=0; //noise control
    float opacity = 0f;
    moon_x = width / 10.0f * 7  - totalRadius;
    moon_y = height / 7.0f * 4 - totalRadius;
    gMoon = createGraphics((int)totalDimension, (int)totalDimension);
    gMoon.beginDraw();
    for (int x = 0; x < totalDimension; x++) {
      for (int y = 0; y < totalDimension; y++) {
        float distance = dist(x, y, totalDimension/2, totalDimension/2);
        vx+=0.04;
        if (distance <= totalRadius) {
          float varNoise = 0f;
          if (distance<=radius) {
            //main
            opacity = 255;
            varNoise = map(noise(vx, vy), 0, 1, 0, 55);
          } else if (distance<= totalRadius) {
            opacity = map(distance, totalRadius, radius, 0, 75);
            varNoise = 0;
          }
          float brightness = 200   + varNoise;
          gMoon.stroke(brightness, brightness, brightness, opacity);
          gMoon.point(x, y);
        }
      }
      vx = 0;
      vy+= 0.04;
    }
    gMoon.endDraw();
  }

  void initGround() {
    gGround = createGraphics(width, height);
    gGround.beginDraw();
    gGround.noStroke();
    gGround.fill(0);
    float locationY = height/5*4;
    gGround.rect(0, locationY, width, locationY);
    gGround.stroke(0);
    //grass
    for (int x = 0; x < width; x+=2) {
      gGround.pushMatrix();
      gGround.translate(x, locationY);
      new Blade(4, random(-20, 20), random(4, 8)).display(gGround);
      gGround.popMatrix();
    }
    gGround.endDraw();
  }

  void initTree() {
    gTree = createGraphics(width, height);
    gTree.beginDraw();
    gTree.translate(width / 10 * 8, height/5*4);
    new Tree().display(gTree);
    gTree.endDraw();
  }

  @Override void draw() {
    push();
    background(0);
    drawStars();
    drawNebula();
    drawMoon();
    drawGround();
    drawTree();
    pop();

    logoRightLower(#ff0000);
  }

  void drawStars() {
    pushMatrix();
    translate(-starsoffset/2, -starsoffset/2);
    translate(gStars.width/2, gStars.height/2);
    skyRotation += rotationIncrement;
    rotate(skyRotation);
    translate(-gStars.width/2, -gStars.height/2);
    image(gStars, 0, 0);
    popMatrix();
  }

  void drawMoon() {
    image(gMoon, moon_x, moon_y);
  }

  void drawNebula() {
    image(createNebula(), 0, 0);
  }

  PImage createNebula() {
    PImage imgNebula = createImage(width, height, ARGB);
    imgNebula.loadPixels();
    tx = 0f;
    for (int x = 0; x < width; x++) {
      ty = 0f;
      for (int y = 0; y < height; y++) {
        float n = noise(tx, ty, tz);
        float r = map(n, 0, 1, 0, 255);
        float g = map(n, 0, 1, 126, 255);
        float b = 255;
        float opacity = map(n, 0, 1, 0, 150);
        imgNebula.pixels[x+y*width] = color(r, g, b, opacity);
        ty += noiseY;
      }
      tx += noiseX;
      tz += noiseZ;
    }
    imgNebula.updatePixels();
    return imgNebula;
  }

  void drawGround() {
    image(gGround, 0, 0 );
  }

  void drawTree() {
    image(gTree, 0, 0 );
  }


  class Blade {
    float segments;
    float angle;
    float bladeLength;
    Blade(float segments_, float angle_, float bladeLength_) {
      segments = segments_;
      angle = angle_;
      bladeLength = bladeLength_;
    }

    void display(PGraphics g) {
      branch(bladeLength, g);
    }

    void branch(float len, PGraphics g) {
      g.strokeWeight(map(len, 1, bladeLength, 0.1, 3));
      g.line(0, 0, 0, -len);
      g.translate(0, -len);
      len *= 0.6;
      if (len >= 1) {
        g.pushMatrix();
        g.rotate(radians(angle));
        branch(len, g);
        g.popMatrix();
      }
    }
  }

  class Tree {
    void display(PGraphics g) {
      branch(40, 3, 8, g);
    }

    void branch(float len, float sWeight, float depth, PGraphics g) {
      if (depth<=1) {
        g.stroke(0, 40, 47);
      } else {
        g.stroke(0, 0, 0);
      }
      g.strokeWeight(sWeight);
      g.line(0, 0, 0, -len);
      g.translate(0, -len);

      len *= random(0.5, 0.9);
      sWeight *= 0.75;

      if (depth > 0) {
        depth--;
        g.pushMatrix();
        g.rotate(PI/random(3, 10));
        branch(len, sWeight, depth, g);
        g.popMatrix();

        g.pushMatrix();
        g.rotate(-PI/random(3, 10));
        branch(len, sWeight, depth, g);
        g.popMatrix();

        g.pushMatrix();
        g.rotate(6);
        branch(len, sWeight, depth, g);
        g.popMatrix();
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
