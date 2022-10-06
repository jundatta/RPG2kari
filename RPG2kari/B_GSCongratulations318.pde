// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】中内　純(ハンドルネーム：JunKiyoshi)さん
// 【作品名】Peeking Sphere. Draw by openFrameworks
// https://junkiyoshi.com/2022/01/13/
//

class GameSceneCongratulations318 extends GameSceneCongratulationsBase {
  ofMesh face, line;

  //--------------------------------------------------------------
  @Override void setup() {
    face = new ofMesh();
    line = new ofMesh();
  }

  //--------------------------------------------------------------
  void update() {
    face.clear();
    line.clear();

    float phi_deg_step = 5;
    float theta_deg_step = 5;
    float noise_radius = 300;

    for (float radius = 200; radius <= 250; radius += 5) {
      for (float phi_deg = 0; phi_deg < 360; phi_deg += phi_deg_step) {
        for (float theta_deg = 0; theta_deg <= 180; theta_deg += theta_deg_step) {
          var noise_value = openFrameworks.ofNoise(
            noise_radius * cos(radians(phi_deg)) * 0.01,
            noise_radius * sin(radians(phi_deg)) * 0.01,
            noise_radius * cos(radians(theta_deg)) * 0.005 + frameCount * 0.05);
          if (noise_value < 0.55) {
            continue;
          }

          var noise_value_1 = openFrameworks.ofNoise(
            noise_radius * cos(radians(phi_deg)) * 0.01,
            noise_radius * sin(radians(phi_deg)) * 0.01,
            noise_radius * cos(radians(theta_deg - theta_deg_step)) * 0.005 + frameCount * 0.05);
          var noise_value_2 = openFrameworks.ofNoise(
            noise_radius * cos(radians(phi_deg + phi_deg_step)) * 0.01,
            noise_radius * sin(radians(phi_deg + phi_deg_step)) * 0.01,
            noise_radius * cos(radians(theta_deg)) * 0.005 + frameCount * 0.05);
          var noise_value_3 = openFrameworks.ofNoise(
            noise_radius * cos(radians(phi_deg - phi_deg_step)) * 0.01,
            noise_radius * sin(radians(phi_deg - phi_deg_step)) * 0.01,
            noise_radius * cos(radians(theta_deg)) * 0.005 + frameCount * 0.05);
          var noise_value_4 = openFrameworks.ofNoise(
            noise_radius * cos(radians(phi_deg)) * 0.01,
            noise_radius * sin(radians(phi_deg)) * 0.01,
            noise_radius * cos(radians(theta_deg + theta_deg_step)) * 0.005 + frameCount * 0.05);

          var index = face.getNumVertices();
          ArrayList<PVector> vertices = new ArrayList();

          vertices.add(new PVector(
            radius * sin(radians(theta_deg - theta_deg_step * 0.5)) * cos(radians(phi_deg + phi_deg_step * 0.5)),
            radius * sin(radians(theta_deg - theta_deg_step * 0.5)) * sin(radians(phi_deg + phi_deg_step * 0.5)),
            radius * cos(radians(theta_deg - theta_deg_step * 0.5))));
          vertices.add(new PVector(
            radius * sin(radians(theta_deg - theta_deg_step * 0.5)) * cos(radians(phi_deg - phi_deg_step * 0.5)),
            radius * sin(radians(theta_deg - theta_deg_step * 0.5)) * sin(radians(phi_deg - phi_deg_step * 0.5)),
            radius * cos(radians(theta_deg - theta_deg_step * 0.5))));
          vertices.add(new PVector(
            radius * sin(radians(theta_deg + theta_deg_step * 0.5)) * cos(radians(phi_deg + phi_deg_step * 0.5)),
            radius * sin(radians(theta_deg + theta_deg_step * 0.5)) * sin(radians(phi_deg + phi_deg_step * 0.5)),
            radius * cos(radians(theta_deg + theta_deg_step * 0.5))));
          vertices.add(new PVector(
            radius * sin(radians(theta_deg + theta_deg_step * 0.5)) * cos(radians(phi_deg - phi_deg_step * 0.5)),
            radius * sin(radians(theta_deg + theta_deg_step * 0.5)) * sin(radians(phi_deg - phi_deg_step * 0.5)),
            radius * cos(radians(theta_deg + theta_deg_step * 0.5))));

          face.addVertices(vertices);

          face.addIndex(index + 0);
          face.addIndex(index + 1);
          face.addIndex(index + 3);
          face.addIndex(index + 0);
          face.addIndex(index + 3);
          face.addIndex(index + 2);

          if (noise_value_1 < 0.55) {
            line.addVertex(vertices.get(0));
            line.addVertex(vertices.get(1));
            line.addIndex(line.getNumVertices() - 1);
            line.addIndex(line.getNumVertices() - 2);
          }

          if (noise_value_2 < 0.55) {
            line.addVertex(vertices.get(0));
            line.addVertex(vertices.get(2));
            line.addIndex(line.getNumVertices() - 1);
            line.addIndex(line.getNumVertices() - 2);
          }

          if (noise_value_3 < 0.55) {
            line.addVertex(vertices.get(1));
            line.addVertex(vertices.get(3));
            line.addIndex(line.getNumVertices() - 1);
            line.addIndex(line.getNumVertices() - 2);
          }

          if (noise_value_4 < 0.55) {
            line.addVertex(vertices.get(2));
            line.addVertex(vertices.get(3));
            line.addIndex(line.getNumVertices() - 1);
            line.addIndex(line.getNumVertices() - 2);
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

    background(255);
    strokeWeight(1.5);

    rotateX(radians(270));
    rotateZ(radians(frameCount));

    face.draw(color(0));
    line.drawWireframe(color(255));
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
