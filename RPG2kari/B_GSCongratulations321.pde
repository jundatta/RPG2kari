// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】jcponcemathさん
// 【作品名】Waves
// https://openprocessing.org/sketch/1236958
//

class GameSceneCongratulations321 extends GameSceneCongratulationsBase {
  /*

   Original sketch in processing by @hisadan
   
   https://twitter.com/hisadan
   
   https://twitter.com/hisadan/status/1417869746138017794
   
   This version by Juan Carlos Ponce Campuzano
   22/Jul/2021
   #tinycode
   
   One line (262 characters):
   
   */
  float t=0;
  float z=0;
  @Override void setup() {
    //camera(w, 0, 99, 0, 0, 0, 0, 0, -1);
    noFill();
  }
  @Override void draw() {
    push();
    translate(width/2, height/2);

    camera(width, 0, 99, 0, 0, 0, 0, 0, -1);
    ambientLight(255, 255, 255);
    ambientLight(255, 255, 255);
    ambientLight(255, 255, 255);
    ambientLight(255, 255, 255);
    ambientLight(255, 255, 255);
    ambientLight(255, 255, 255);
    ambientLight(255, 255, 255);

    background(0);
    for (float r=0; r<999; r+=2) {
      int c = (int)(64*sin(t+r/9.0f)+64);
      stroke(c, c+64, c+128, 255 * 0.75f);
      circle(0, 0, r);
    }
    t-=0.1;
    push();
    translate(0, 0, 9*cos(z));
    fill(#204060);
    sphere(45);
    pop();
    z+=PI/30.0f;
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
