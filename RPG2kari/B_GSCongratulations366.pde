// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】はぅ君さん
// 【作品名】つぶやきCoding | 2022/10/25
// https://0000.studio/haukun/broadcasts/893d1463-cdde-483c-9cba-fcf8013ab20c/archive
// https://twitter.com/Hau_kun
//

class GameSceneCongratulations366 extends GameSceneCongratulationsBase {
  float t=0;
  float W = 720;
  @Override void setup() {
  }
  @Override void draw() {
    push();
    t+=.03;
    //background(0, 50);
    noStroke();
    fill(0, 50);
    rect(0, 0, width, height);
    noFill();
    for (float j=0; j++<9; ) {
      for (float i=0; i++<200; ) {
        stroke(255, i/3.0f);
        beginShape();
        float I=i/99+t;
        float X=noise(j, I)*W;
        float Y=noise(j, I, 9)*W;
        for (float d=0; d<20; d++) {
          float R=noise(I+d)*99;
          float D=(200-i)/9.0f;
          vertex(X+=cos(R)*(D), Y+=sin(R)*D+D);
        }
        endShape();
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
