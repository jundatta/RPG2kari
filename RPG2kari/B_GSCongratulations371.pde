// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】はぅ君さん
// 【作品名】つぶやきCoding | 2022/10/20
// https://0000.studio/haukun/broadcasts/cabc0564-f8bd-4e33-bdac-d3f60972403e/archive
// https://twitter.com/Hau_kun（ソースは2022/10/20のツイートを参照ください）
//

class GameSceneCongratulations371 extends GameSceneCongratulationsBase {
  float t=0;
  final int OrgW = 720;
  PGraphics pg;
  @Override void setup() {
    pg = createGraphics(OrgW, OrgW, P3D);
  }
  @Override void draw() {
    push();
    pg.beginDraw();
    t+=.05;
    //background(0, 50);
    pg.noStroke();
    pg.fill(0, 50);
    pg.rect(0, 0, pg.width, pg.height);
    pg.noFill();
    pg.stroke(255, 50);
    float F=1;
    for (float r=0; r<TAU; r+=.01) {
      F=-F;
      pg.beginShape();
      float X=360;
      float Y=360;
      for (float d=0; d<80; d++) {
        float R;
        pg.vertex(X+=cos(R=r+(noise(tan(r*4)/50, d/9-t)-.5)*d/6*F)*d/7, Y+=sin(R)*d/7);
      }
      pg.endShape();
    }
    pg.endDraw();
    image(pg, (width-OrgW)/2, 0);
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
