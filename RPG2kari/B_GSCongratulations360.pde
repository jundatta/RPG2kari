// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】SamuelYANさん
// 【作品名】3D Mosaic
// https://neort.io/art/caumivk3p9f2v73up320
//

class GameSceneCongratulations360 extends GameSceneCongratulationsBase {
  // by SamuelYAN
  // more works //
  // https://twitter.com/SamuelAnn0924
  // https://www.instagram.com/samuel_yan_1990/

  // learn from https://p5js.org/examples/arrays-array-objects.html

  float ranges;
  long seed = (long)random(1) * 1247;
  float margin, grad;
  float str_wei = 0;

  // colors
  color[] colors0 = {#281914, #1a1a1a, #202020, #242e30};
  color[] colors1 = {#fef9fb, #fafdff, #ffffff, #fcfbf4, #f9f8f6};
  // old plette
  color[] colors2 = {#8c75ff, #c553d2, #2dfd60, #2788f5, #23054f, #f21252, #8834f1, #c4dd92, #184fd3, #f9fee2, #2E294E, #541388, #F1E9DA, #FFD400, #D90368, #e9baaa, #ffa07a, #164555, #ffe1d0, #acd9e7, #4596c7, #6d8370, #e45240, #21d3a4, #3303f9, #cd2220, #173df6, #244ca8, #a00360, #b31016};
  // new plette 20220616
  color[] colors3 = {#042940, #005C53, #9FC131, #DBF227, #D6D58E};
  color[] colors4 = {#F28DC4, #5EF2E3, #F2CB07, #F2B807, #F2A7A7};
  color[] colors5 = {#2D2E40, #5B66A6, #F27405, #F25C05, #F2C5BB};
  color[] colors6 = {#F2B279, #D9936A, #BF8069, #BF604B, #8C665E};
  color[] colors7 = {#7ABF85, #95BF98, #ADBF26, #D8D9D0, #6F7302};

  color[] colors_cyber = {#ee0cf2, #352ef2, #1df252, #f2e41d};
  color[] color1, color2;
  color colorbg;

  float unit_x, unit_y;
  float count;
  float stop_count = 0;
  float t = 0;
  float rez = 0;

  int xOff, yOff, zOff;

  @Override void setup() {
    randomSeed(seed);
    colorbg = P5JS.random(colors0);
    background(colorbg);
    t = rez = 0.01;
    //  color1 = random([colors3, colors4, colors5, colors6, colors7]);
    color[][] cc = {colors3, colors4, colors5, colors6, colors7};
    int idx = (int)random(cc.length);
    color1 = cc[idx];
    //color2 = random([colors3, colors4, colors5, colors6, colors7]);
    idx = (int)random(cc.length);
    color2 = cc[idx];
    // pixelDensity(5);
    xOff = 0;
    yOff = 0;
    zOff = 0;
  }
  @Override void draw() {
    push();
    randomSeed(seed);
    background(colorbg);

    //translate(-width/2, -height/2);
    float plus = 10;
    for (var i = xOff; i < width - xOff; i += plus) {
      for (var j = yOff; j < height - yOff; j += plus) {
        strokeWeight(random(1));
        // strokeCap(SQUARE);
        var n = noise(i * rez, j * rez, frameCount* 0.01);
        if (n > 0.35) {
          stroke(P5JS.random(colors1));
          fill(P5JS.random(color1));
        } else {
          noFill();
          stroke(P5JS.random(color2));
        }

        push();
        translate(i, j);
        if (n > 0.5) {
          rotateZ(t);
          box(plus, plus, 50);
        } else {
          box(plus*0.1);
        }
        pop();
      }
    }
    t += 0.01;
    zOff ++;
    // noLoop();
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
