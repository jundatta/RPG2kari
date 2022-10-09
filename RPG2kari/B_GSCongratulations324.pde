// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】MGさん
// 【作品名】第12回課題
// https://openprocessing.org/sketch/1047844
//

class GameSceneCongratulations324 extends GameSceneCongratulationsBase {
  class Box {
    float x, y, z;
    color c;
    Box(float x, float y, float z) {
      this.x = x;
      this.y = y;
      this.z = z;
    }
  }
  Box[] boxes = new Box[40];

  PImage img, img2, img3;
  PShape cylinder, box1, box2;

  void preload() {
    img = loadImage("data/324/jura-face.png");
    img2 = loadImage("data/324/sida-face.png");
    img3 = loadImage("data/324/back_1.png");
  }

  @Override void setup() {
    preload();

    //angleMode(DEGREES);
    colorMode(HSB, 360, 100, 100, 100);

    for (var i = 0; i < boxes.length; i = i + 1) {
      float x = random(-width / 2, width / 2);
      float y = random(-height / 2, height / 2);
      float z = random(-500, 500);
      boxes[i] = new Box(x, y, z);
    }

    cylinder = createCan(750, 1500);
    cylinder.setStroke(false);
    cylinder.setTexture(img3);

    //box1 = createShape(BOX, 60);
    box1 = createShape(BOX, 1);
    box1.setTexture(img);
    box1.setStroke(color(0, 0, 100));

    //box2 = createShape(BOX, 60);
    box2 = createShape(BOX, 1);
    box2.setTexture(img2);
    box2.setStroke(color(0, 0, 100));
  }
  @Override void draw() {
    push();
    translate(width/2, height/2);
    background(220, 80, 20);

    // orbitControl();

    // 背景
    shape(cylinder);

    // 箱1
    for (Box box : boxes) {
      push();
      translate(box.x, box.y, box.z);
      rotateX(radians((box.x + frameCount) / 3.0f));
      rotateY(radians((box.y + frameCount) / 4.0f));
      rotateZ(radians((box.z + frameCount) / 5.0f));
      scale(60);
      shape(box1);

      box.y = box.y + 3;
      if (box.y > 500) {
        box.y = -500;
      }
      pop();
    }

    // 箱2
    for (Box box : boxes) {
      push();
      translate(box.x, box.y, box.z);
      rotateX(radians((box.x + frameCount) / 3.0f));
      rotateY(radians((box.y + frameCount) / 4.0f));
      rotateZ(radians((box.z + frameCount) / 5.0f));
      scale(60);
      shape(box2);
      pop();

      box.y = box.y + 3;
      if (box.y > 500) {
        box.y = -500;
      }
    }
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
