// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】中内　純(ハンドルネーム：JunKiyoshi)さん
// 【作品名】Shaving spheres. Draw by openFrameworks
// https://junkiyoshi.com/2021/12/16/
//

class GameSceneCongratulations349 extends GameSceneCongratulationsBase {
  ofMesh face, frame;

  //--------------------------------------------------------------
  @Override void setup() {
    face = new ofMesh();
    frame = new ofMesh();
  }

  //--------------------------------------------------------------
  void update() {
    randomSeed(39);

    face.clear();
    frame.clear();

    float phi_deg_step = 5;
    float theta_deg_step = 5;

    ArrayList<PVector> noise_location_list = new ArrayList();

    for (int i = 0; i < 20; i++) {
      var noise_location = new PVector(
        map(openFrameworks.ofNoise(random(1000), ofGetFrameNum() * 0.005), 0, 1, -250, 250),
        map(openFrameworks.ofNoise(random(1000), ofGetFrameNum() * 0.005), 0, 1, -250, 250),
        map(openFrameworks.ofNoise(random(1000), ofGetFrameNum() * 0.005), 0, 1, -250, 250));
      noise_location_list.add(noise_location);
    }

    for (float radius = 50; radius <= 250; radius += 15) {
      for (float phi_deg = 0; phi_deg < 360; phi_deg += phi_deg_step) {
        for (float theta_deg = 0; theta_deg <= 360; theta_deg += theta_deg_step) {
          var location = new PVector(
            radius * sin(theta_deg * DEG_TO_RAD) * cos(phi_deg * DEG_TO_RAD),
            radius * sin(theta_deg * DEG_TO_RAD) * sin(phi_deg * DEG_TO_RAD),
            radius * cos(theta_deg * DEG_TO_RAD));

          boolean draw_flag = true;
          for (int i = 0; i < noise_location_list.size(); i++) {
            if (PVector.dist(location, noise_location_list.get(i)) < 100) {
              draw_flag = false;
              break;
            }
          }

          if (draw_flag) {
            var index = face.getNumVertices();
            ArrayList<PVector> vertices = new ArrayList();

            vertices.add(new PVector(
              radius * sin((theta_deg - theta_deg_step * 0.5) * DEG_TO_RAD) * cos((phi_deg + phi_deg_step * 0.5) * DEG_TO_RAD),
              radius * sin((theta_deg - theta_deg_step * 0.5) * DEG_TO_RAD) * sin((phi_deg + phi_deg_step * 0.5) * DEG_TO_RAD),
              radius * cos((theta_deg - theta_deg_step * 0.5) * DEG_TO_RAD)));
            vertices.add(new PVector(
              radius * sin((theta_deg - theta_deg_step * 0.5) * DEG_TO_RAD) * cos((phi_deg - phi_deg_step * 0.5) * DEG_TO_RAD),
              radius * sin((theta_deg - theta_deg_step * 0.5) * DEG_TO_RAD) * sin((phi_deg - phi_deg_step * 0.5) * DEG_TO_RAD),
              radius * cos((theta_deg - theta_deg_step * 0.5) * DEG_TO_RAD)));
            vertices.add(new PVector(
              radius * sin((theta_deg + theta_deg_step * 0.5) * DEG_TO_RAD) * cos((phi_deg + phi_deg_step * 0.5) * DEG_TO_RAD),
              radius * sin((theta_deg + theta_deg_step * 0.5) * DEG_TO_RAD) * sin((phi_deg + phi_deg_step * 0.5) * DEG_TO_RAD),
              radius * cos((theta_deg + theta_deg_step * 0.5) * DEG_TO_RAD)));
            vertices.add(new PVector(
              radius * sin((theta_deg + theta_deg_step * 0.5) * DEG_TO_RAD) * cos((phi_deg - phi_deg_step * 0.5) * DEG_TO_RAD),
              radius * sin((theta_deg + theta_deg_step * 0.5) * DEG_TO_RAD) * sin((phi_deg - phi_deg_step * 0.5) * DEG_TO_RAD),
              radius * cos((theta_deg + theta_deg_step * 0.5) * DEG_TO_RAD)));

            face.addVertices(vertices);
            frame.addVertices(vertices);

            face.addIndex(index + 0);
            face.addIndex(index + 1);
            face.addIndex(index + 3);
            face.addIndex(index + 0);
            face.addIndex(index + 3);
            face.addIndex(index + 2);

            frame.addIndex(index + 0);
            frame.addIndex(index + 1);
            frame.addIndex(index + 0);
            frame.addIndex(index + 2);
            frame.addIndex(index + 3);
            frame.addIndex(index + 1);
            frame.addIndex(index + 3);
            frame.addIndex(index + 2);
          }
        }
      }
    }
  }

  //--------------------------------------------------------------
  @Override void draw() {
    push();
    update();
    translate(width/2, height/2);
    background(0);
    strokeWeight(1.5);

    ofRotateX(90);
    ofRotateZ(ofGetFrameNum());

    face.draw(color(0));

    frame.drawWireframe(color(239));
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
