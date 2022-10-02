// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】へいへい📫１人前のプログラマ＆脱引きこもり目指す🔥
// 【作品名】randomMoveDotRandomMoveMarvelDots
// https://0000.studio/shoheyhey
// 【NEORT】へいへい📬リモートで生活＆月収20万円めざす(脱引きこもりも
// https://neort.io/art/ccsgafc3p9f4hhfti9eg
//

class GameSceneCongratulations307 extends GameSceneCongratulationsBase {

  class DOT {
    float x, y;
    float vx, vy;
    float transparent;
    color col;
    float size;
    DOT(float x, float y, float vx, float vy, float transparent, color col, float size) {
      this.x = x;
      this.y = y;
      this.vx = vx;
      this.vy = vy;
      this.transparent = transparent;
      this.col = col;
      this.size = size;
    }
  }
  ArrayList<DOT> dts;
  color[] colorCode = {#eebb00, #77ddaa, #ee99dd};

  @Override void setup() {
    dts = new ArrayList();
    //falsy(false,null,0,undifind...)ならcreateCanvas
  }
  @Override void draw() {
    push();
    background(255);

    float d = random(TWO_PI);
    DOT dot = new DOT(random(width), random(height),
      2*random(0.11, 1.5)*cos(d), 2*random(0.11, 1.5)*cos(d),
      100, P5JS.random(colorCode), random(40));
    dts.add(dot);
    for (DOT dt : dts) {
      dt.x += dt.vx;
      dt.y += dt.vy;
      dt.transparent -= 1;

      noStroke();
      int opacity = (int)(dt.transparent*2.55);
      if (dt.transparent <= 9) {
        opacity = 0;
      }
      color col = dt.col;
      fill(red(col), green(col), blue(col), opacity);
      ellipse(dt.x, dt.y, dt.size, dt.size);
    }//end for

    ArrayList<DOT> newDots = new ArrayList();
    for (DOT dt : dts) {
      if (0 < dt.transparent) {
        newDots.add(dt);
      }
    }
    dts = newDots;
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
