// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】中内　純(ハンドルネーム：JunKiyoshi)さん
// 【作品名】10 PRINT on Sphere. Draw by openFrameworks
// https://junkiyoshi.com/2021/12/29/
//

class GameSceneCongratulations327 extends GameSceneCongratulationsBase {
  ofMesh frame;

  @Override void setup() {
    frame = new ofMesh();
  }

  //--------------------------------------------------------------
  void update() {
    randomSeed(39);

    frame.clear();

    float phi_deg_step = 5;
    float theta_deg_step = 5;

    float radius = 250;

    for (float phi_deg = 0; phi_deg < 360; phi_deg += phi_deg_step) {
      for (float theta_deg = 0; theta_deg <= 180; theta_deg += theta_deg_step) {
        var noise_value = openFrameworks.ofNoise(random(1000));
        if (noise_value < 0.5) {
          frame.addVertex(new PVector(
            radius * sin((theta_deg - theta_deg_step * 0.5) * DEG_TO_RAD) * cos((phi_deg + phi_deg_step * 0.5) * DEG_TO_RAD),
            radius * sin((theta_deg - theta_deg_step * 0.5) * DEG_TO_RAD) * sin((phi_deg + phi_deg_step * 0.5) * DEG_TO_RAD),
            radius * cos((theta_deg - theta_deg_step * 0.5) * DEG_TO_RAD)));
          frame.addVertex(new PVector(
            radius * sin((theta_deg + theta_deg_step * 0.5) * DEG_TO_RAD) * cos((phi_deg - phi_deg_step * 0.5) * DEG_TO_RAD),
            radius * sin((theta_deg + theta_deg_step * 0.5) * DEG_TO_RAD) * sin((phi_deg - phi_deg_step * 0.5) * DEG_TO_RAD),
            radius * cos((theta_deg + theta_deg_step * 0.5) * DEG_TO_RAD)));
        } else {
          frame.addVertex(new PVector(
            radius * sin((theta_deg - theta_deg_step * 0.5) * DEG_TO_RAD) * cos((phi_deg - phi_deg_step * 0.5) * DEG_TO_RAD),
            radius * sin((theta_deg - theta_deg_step * 0.5) * DEG_TO_RAD) * sin((phi_deg - phi_deg_step * 0.5) * DEG_TO_RAD),
            radius * cos((theta_deg - theta_deg_step * 0.5) * DEG_TO_RAD)));
          frame.addVertex(new PVector(
            radius * sin((theta_deg + theta_deg_step * 0.5) * DEG_TO_RAD) * cos((phi_deg + phi_deg_step * 0.5) * DEG_TO_RAD),
            radius * sin((theta_deg + theta_deg_step * 0.5) * DEG_TO_RAD) * sin((phi_deg + phi_deg_step * 0.5) * DEG_TO_RAD),
            radius * cos((theta_deg + theta_deg_step * 0.5) * DEG_TO_RAD)));
        }
        frame.addIndex(frame.getNumVertices() - 1);
        frame.addIndex(frame.getNumVertices() - 2);
      }
    }
  }

  //--------------------------------------------------------------
  @Override void draw() {
    push();
    update();

    translate(width/2, height/2);
    background(255);
    strokeWeight(3);

    rotateX(radians(90));
    rotateZ(radians(frameCount * 0.6666666666666));

    push();
    noStroke();
    fill(255);
    sphere(248);
    pop();

    frame.drawWireframe(color(0));

    noFill();
    stroke(0);
    strokeWeight(8);
    for (var vertex : frame.getVertices()) {
      point(vertex.x, vertex.y, vertex.z);
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
