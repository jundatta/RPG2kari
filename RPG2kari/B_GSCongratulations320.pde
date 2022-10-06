// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】中内　純(ハンドルネーム：JunKiyoshi)さん
// 【作品名】Sun and sea. Draw by openFrameworks
// https://junkiyoshi.com/2022/01/05/
//

class GameSceneCongratulations320 extends GameSceneCongratulationsBase {
  ofMesh mesh;

  //--------------------------------------------------------------
  @Override void setup() {
    mesh = new ofMesh();
  }

  //--------------------------------------------------------------
  void update() {
    randomSeed(39);

    mesh.clear();

    int span = 6;
    PVector seed = new PVector(random(1000), random(1000), random(1000));
    for (int x = -500; x <= 500; x += span) {
      for (int y = -300; y <= 300; y += span) {
        ArrayList<PVector> vertices = new ArrayList();
        vertices.add(rotate(seed, new PVector(x, y, 0)));
        vertices.add(rotate(seed, new PVector(x + span, y, 0)));
        vertices.add(rotate(seed, new PVector(x + span, y + span, 0)));
        vertices.add(rotate(seed, new PVector(x, y + span, 0)));

        for (PVector vertex : vertices) {
          vertex.z = map(vertex.z, -5, 5, -30, 30);
        }

        mesh.addVertices(vertices);

        mesh.addIndex(mesh.getNumVertices() - 1);
        mesh.addIndex(mesh.getNumVertices() - 2);
        mesh.addIndex(mesh.getNumVertices() - 3);
        mesh.addIndex(mesh.getNumVertices() - 1);
        mesh.addIndex(mesh.getNumVertices() - 3);
        mesh.addIndex(mesh.getNumVertices() - 4);
      }
    }
  }

  //--------------------------------------------------------------
  @Override void draw() {
    push();
    update();

    translate(width/2, height/2);

    background(255, 0, 0);

    rotateX(radians(270));

    strokeWeight(1);
    mesh.draw(color(255));

    translate(0, 0, 0.01);
    mesh.drawWireframe(color(0));

    strokeWeight(3);

    translate(0, 400, 0);
    rotateX(radians(90));

    noFill();
    stroke(0);
    circle(0, 0, 250 * 2.0f);

    fill(255);
    circle(0, 0, 249.5 * 2.0f);
    pop();

    logoRightLower(#ff0000);
  }

  //--------------------------------------------------------------
  PVector rotate(PVector seed, PVector location) {
    //float deg_x = ofMap(ofNoise(seed.x, location.x * 0.003, location.y * 0.003 + ofGetFrameNum() * 0.0085), 0, 1, -180, 180);
    //float deg_y = ofMap(ofNoise(seed.y, location.x * 0.003, location.y * 0.003 + ofGetFrameNum() * 0.0085), 0, 1, -180, 180);
    //float deg_z = ofMap(ofNoise(seed.z, location.x * 0.003, location.y * 0.003 + ofGetFrameNum() * 0.0085), 0, 1, -180, 180);
    float rad_x = map(openFrameworks.ofNoise(seed.x, location.x * 0.003, location.y * 0.003 + frameCount * 0.0085), 0, 1, -PI, PI);
    float rad_y = map(openFrameworks.ofNoise(seed.y, location.x * 0.003, location.y * 0.003 + frameCount * 0.0085), 0, 1, -PI, PI);
    float rad_z = map(openFrameworks.ofNoise(seed.z, location.x * 0.003, location.y * 0.003 + frameCount * 0.0085), 0, 1, -PI, PI);

    //auto rotation_x = glm::rotate(glm::mat4(), deg_x * (float)DEG_TO_RAD, glm::vec3(1, 0, 0));
    //auto rotation_y = glm::rotate(glm::mat4(), deg_y * (float)DEG_TO_RAD, glm::vec3(0, 1, 0));
    //auto rotation_z = glm::rotate(glm::mat4(), deg_z * (float)DEG_TO_RAD, glm::vec3(0, 0, 1));
    PMatrix3D mat = new PMatrix3D();
    mat.rotateZ(rad_z);
    mat.rotateY(rad_y);
    mat.rotateX(rad_x);

    //auto tmp = glm::vec3(5 * cos(0 * DEG_TO_RAD), 5 * sin(0 * DEG_TO_RAD), 0);
    //tmp = glm::vec4(tmp, 0) * rotation_z * rotation_y * rotation_x;
    PVector tmp = new PVector(5 * cos(radians(0)), 5 * sin(radians(0)), 0);
    tmp = mat.mult(tmp, null);

    //return location + tmp;
    return location.add(tmp);
  }
  
  @Override void mousePressed() {
    gGameStack.change(new GameSceneTitle());
  }
  @Override void keyPressed() {
    super.keyPressed();

    gGameStack.change(new GameSceneTitle());
  }
}
