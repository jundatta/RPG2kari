// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】jacques maireさん
// 【作品名】trois faces
// https://openprocessing.org/sketch/1031568
//

class GameSceneCongratulations332 extends GameSceneCongratulationsBase {
  /*
jacques maire
   fork du sketch de Saskia Freeke 171027
   171027
   Big cube consisted of small cubes
   only outer sides, no inner cubes.
   */

  float t;
  float theta;
  int maxFrameCount = 175;

  int a = 177;
  int space = 17*17; // size of cube for for loops

  color c1;
  color c2;
  float anx, any;

  @Override void setup() {
    anx=2.55;
    any=0.77;
  }
  @Override void draw() {
    push();
    background(50, 0, 70);
    translate(width/2, height/2);
    t = (float)frameCount/maxFrameCount;

    theta = TWO_PI*t;

    directionalLight(205, 245, 255, 200.0, 30, 10);
    ambientLight(100, 150, 255);
    rotateY(anx);
    rotateX(any);

    // 3 nested for loops to create sides

    for (int x = -space; x <= space; x += 21) {
      for (int y = -space; y <= space; y += 21) {
        for (int z = -space; z <= space; z += 900) {
          // map size of small cubes with offset
          float offSet = x*y*z/a;
          float st=sin(-theta+offSet*(-0.00005));
          float sz = map(st, -1, 1, 0.0, 20.0);

          color c2 = color(255, 255, 0);
          color c1 = color(120, 220, 155);

          if (abs(x*y)>15000 ) {
            fill(c1);
            stroke(c2);
          } else {
            fill(c2);
            stroke(c1);
          }

          // small blocks, 3 times to create cube
          shp(x, y, z, sz);
          shp(y, z, x, sz);
          shp(z, x, y, sz);
        }
      }
    }
    pop();

    logoRightLower(#ff0000);
  }

  void shp(float x, float y, float z, float d) {
    noStroke();
    pushMatrix();
    translate(x, y, z);
    box(d);
    popMatrix();
  }

  @Override void mouseMoved() {
    anx= map(mouseX, 0.0, width, 2.34, 2.74);
    any= map(mouseY, 0.0, height, 0.57, 0.97);
  }

  @Override void mousePressed() {
    gGameStack.change(new GameSceneTitle());
  }
  @Override void keyPressed() {
    super.keyPressed();

    gGameStack.change(new GameSceneTitle());
  }
}
