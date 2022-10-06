// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】KomaTebeさん
// 【作品名】noPersp03
// https://openprocessing.org/sketch/1276293
//

class GameSceneCongratulations319 extends GameSceneCongratulationsBase {
  @Override void setup() {
  }
  @Override void draw() {
    push();
    translate(width/2, height/2);
    camera(0, 300, -500, 0, 0, 0, 0, 1, 0);

    background(0, 61, 78);
    rotateY(frameCount * 0.01);
    rotateX(frameCount * 0.005);
    rotateZ(frameCount * 0.02);
    ambientLight(0, 10, 0);
    //specularMaterial(255, 255, 255);
    specular(255, 255, 255);

    pointLight(100, 255, 10, -500, 1000, -500);
    pointLight(0, 77, 125, 500, -1000, 500);
    strokeWeight(3);
    stroke(130);
    noStroke();
    // カリング手に負えませんでした...orz
    // 。。。ギブアップ
    //frustum(width, -width, height, -height, -1000, 10);
    //g.enable(g.CULL_FACE);
    //g.cullFace(g.BACK);

    box(100);
    translate(-100, -100, -100);
    box(100);
    translate(200, 0, 0);
    box(100);
    translate(0, 0, 200);
    box(100);
    translate(-200, 0, 0);
    box(100);
    //
    translate(0, 200, -200);
    box(100);
    translate(200, 0, 0);
    box(100);
    translate(0, 0, 200);
    box(100);
    translate(-200, 0, 0);
    box(100);
    pop();

    lights();
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
