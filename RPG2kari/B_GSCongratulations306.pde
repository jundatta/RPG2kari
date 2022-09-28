// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】burculaさん
// 【作品名】emergent chaos
// https://openprocessing.org/sketch/1462828
//

class GameSceneCongratulations306 extends GameSceneCongratulationsBase {

  /*
  references:
   for the dragon curve: https://openprocessing.org/sketch/847651
   for the sierpinski carpet: https://breaksome.tech/coding-the-sierpinski-carpet-in-p5js/
   */

  //var t = [[320, 0],
  //  [528, 360],
  //  [112, 360]
  //];
  class XY {
    float x, y;
    XY(float x, float y) {
      this.x = x;
      this.y = y;
    }
  }
  XY[] t;

  float Px, Py;
  float max_iter = 90000;
  float theta, N, size_;
  float size=267;
  float angle = 45;
  float rand = 0.66;
  float l;
  float ints;
  color[] s_carpet_colors = {#1a62ff, #80a8ff, #99b9ff, #3374ff};

  color[] draw_colors = {#FDDA16, #6158c4, #a70310, #CCFF00};

  @Override void setup() {
    t = new XY[3];
    t[0] = new XY(320, 0);
    t[1] = new XY(528, 360);
    t[2] = new XY(112, 360);

    initializeFields();
  }
  @Override void draw() {
    push();
    // 適当にいい感じな切り替わりタイミングのつもりにゃ
    randomSeed((long)(frameCount*0.02f));

    background(77, 77, 255);
    noStroke();
    //noFill();

    // sierpinski carpet
    translate(width / 2 - size / 2, height / 2 - size / 2);
    generateSierpinskiCarpet(size);

    //fractal tree
    stroke(random(0, 110), 255, random(10, 200));
    strokeWeight(random(1, 2));
    push();
    translate(width/2, height);
    drawFractalTree(500);
    translate(width/2, height/2);
    drawFractalTree(500);
    translate(width, height/2);
    drawFractalTree(random(400, 500));

    pop();

    //dragon curve
    stroke(255, random(10, 102), 255);
    strokeWeight(random(0.5, 2));
    turn_left(l, ints);
    turn_right(l, ints);
    translate(width, height/2);

    turn_left(l, ints);
    turn_right(l, ints);

    stroke(254, 80, 0);
    strokeWeight(random(0, 2));
    noFill();
    translate(width / 2, height / 1.8);
    ellipse(0, 0, size, size);

    stroke(254, 80, 0);
    strokeWeight(random(0.7, 1.5));
    pop();

    logoRightLower(#ff0000);
  }
  void generateSierpinskiCarpet(float size) {
    if (size > 4) {
      color[] main_sq = {#4d88ff, #3377ff, #1a66ff, #0055ff};

      //fill(26, 102, 255);
      fill(P5JS.random(main_sq));
      rect(0, 0, size, size);

      size /= 3;

      //Left
      fill(P5JS.random(s_carpet_colors));
      push();
      translate(0 - size * 3 + size, 0 + size);
      rect(0, 0, size, size);
      generateSierpinskiCarpet(size);
      pop();

      //Right
      fill(P5JS.random(s_carpet_colors));
      push();
      translate(0 + size * 5 - size, 0 + size);
      rect(0, 0, size, size);
      generateSierpinskiCarpet(size);
      pop();

      //Top
      fill(P5JS.random(s_carpet_colors));
      push();
      translate(0 + size, 0 - size * 3 + size);
      rect(0, 0, size, size);
      generateSierpinskiCarpet(size);
      pop();

      //Bottom
      fill(P5JS.random(s_carpet_colors));
      push();
      translate(0 + size, 0 + size * 5 - size);
      rect(0, 0, size, size);
      generateSierpinskiCarpet(size);
      pop();

      //Top Left
      fill(P5JS.random(s_carpet_colors));
      push();
      translate(0 - size * 3 + size, 0 - size * 3 + size);
      rect(0, 0, size, size);
      generateSierpinskiCarpet(size);
      pop();

      //Top Right
      fill(P5JS.random(s_carpet_colors));
      push();
      translate(0 + size * 5 - size, 0 - size * 3 + size);
      rect(0, 0, size, size);
      generateSierpinskiCarpet(size);
      pop();

      //Bottom Left
      fill(P5JS.random(s_carpet_colors));
      push();
      translate(0 - size * 3 + size, 0 + size * 5 - size);
      rect(0, 0, size, size);
      generateSierpinskiCarpet(size);
      pop();

      //Bottom Right
      fill(P5JS.random(s_carpet_colors));
      push();
      translate(0 + size * 5 - size, 0 + size * 5 - size);
      rect(0, 0, size, size);
      generateSierpinskiCarpet(size);
      pop();
    }
  }
  //************
  void turn_right(float l, float ints) {
    if (ints == 0) {
      line(0, 0, 0, -l);
      translate(0, -l);
    } else {
      turn_left(l, ints - 1);
      rotate(radians(90));
      turn_right(l, ints - 1);
    }
  }

  void turn_left(float l, float ints) {
    if (ints == 0) {
      line(0, 0, 0, -l);
      translate(0, -l);
    } else {
      turn_left(l, ints - 1);
      rotate(radians(-90));
      turn_right(l, ints - 1);
    }
  }
  void drawFractalTree(float len) {
    if (len <3) {
      return;
    }

    line(0, 0, 0, -len);

    translate(0, -len);

    push();
    rotate(angle);
    drawFractalTree(len*0.66);
    pop();

    push();
    rotate(-angle);
    drawFractalTree(len*0.66);
    pop();
  }

  void generateSierpinskiCircles(float size) {
    size /= 2;

    if (size > 2) {
      //Top
      push();
      translate(0, -size * 2);
      ellipse(0, 0, size, size);
      generateSierpinskiCircles(size);
      pop();

      //Right
      push();
      rotate(120);
      translate(0, -size * 2);
      ellipse(0, 0, size, size);
      generateSierpinskiCircles(size);
      pop();

      //Left
      push();
      rotate(240);
      translate(0, -size * 2);
      ellipse(0, 0, size, size);
      generateSierpinskiCircles(size);
      pop();
    }

    if (size <= 2) size = 300;
  }

  void sierpinskiTriangle() {
    //stroke(128,49,167);
    stroke(P5JS.random(draw_colors));
    strokeWeight(0.3);
    for (float i = 0; i < max_iter; i++)
    {
      int r=int(random(0, 3));
      Px=Px + (t[r].x-Px)/2;
      Py=Py + (t[r].y-Py)/2;
      point(Px, Py);
    }
  }

  void initializeFields() {
    //l=random(5, 10);
    l =5;
    ints = 13;
    angle = random(45, 180);
    rand = random(0, 1);
    size_=random(300, 500);
    Px = random(200, 500);
    Py = random(1, 100);
  }
  
  @Override void mousePressed() {
    gGameStack.change(new GameSceneTitle());
  }
  @Override void keyPressed() {
    super.keyPressed();

    gGameStack.change(new GameSceneTitle());
  }
}
