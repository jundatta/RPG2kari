// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】中内　純(ハンドルネーム：JunKiyoshi)さん
// 【作品名】Fives. Draw by openFrameworks
// https://junkiyoshi.com/2021/12/15/
//

class GameSceneCongratulations341 extends GameSceneCongratulationsBase {
  PVector[] vertices;
  //--------------------------------------------------------------
  @Override void setup() {
    vertices = loadOutline("data/341/5.txt");
  }

  //--------------------------------------------------------------
  void update() {
    randomSeed(39);
  }

  //--------------------------------------------------------------
  @Override void draw() {
    push();
    update();
    translate(width/2, height/2);
    background(255);

    rotateY(radians(frameCount * 0.66666666666666666));

    for (int i = 0; i < 150 * 0.5f; i++) {
      float x = random(-300, 300);
      float y = random(-300, 300);
      float z = random(-300, 300);
      float rad_x = random(-TAU, TAU);
      float rad_y = random(-TAU, TAU);
      float rad_z = random(-TAU, TAU);

      var translate_location = new PVector(x, y, z);
      translate_location.normalize();
      translate_location.mult(random(540));
      var len = (int)(translate_location.mag() + frameCount * 2) % 540;
      translate_location.normalize();
      translate_location.mult(len);

      pushMatrix();
      translate(translate_location.x, translate_location.y, translate_location.z);
      rotateZ(rad_z);
      rotateY(rad_y);
      rotateX(rad_x);

      ArrayList<PVector> mesh_vertices = new ArrayList();
      ArrayList<PVector> base_location_list = new ArrayList();

      float stringWidth = 37;
      float stringHeight = 49;
      for (int vertices_index = 0; vertices_index < vertices.length; vertices_index++) {
        var base_location = new PVector(stringWidth * 0.5, stringHeight * 0.5, 0);
        var location = PVector.sub(vertices[vertices_index], base_location);
        mesh_vertices.add(location);
        base_location_list.add(base_location);
      }

      ofMesh face = new ofMesh();
      ofMesh line = new ofMesh();
      for (int k = 0; k < mesh_vertices.size(); k++) {
        //face.addVertex(base_location_list[k] + glm::vec3(mesh_vertices[k] - glm::vec3(0, 0, 5)));
        PVector wV = new PVector(0, 0, 5);
        PVector v = PVector.sub(mesh_vertices.get(k), wV);
        v = PVector.add(base_location_list.get(k), v);
        face.addVertex(v);
        line.addVertex(v);
        //face.addVertex(base_location_list[k] + glm::vec3(mesh_vertices[k] + glm::vec3(0, 0, 5)));
        v = PVector.add(mesh_vertices.get(k), wV);
        v = PVector.add(base_location_list.get(k), v);
        face.addVertex(v);
        line.addVertex(v);

        if (k > 0) {
          face.addIndex(face.getNumVertices() - 1);
          face.addIndex(face.getNumVertices() - 2);
          face.addIndex(face.getNumVertices() - 4);
          face.addIndex(face.getNumVertices() - 1);
          face.addIndex(face.getNumVertices() - 3);
          face.addIndex(face.getNumVertices() - 4);

          line.addIndex(line.getNumVertices() - 1);
          line.addIndex(line.getNumVertices() - 3);
          line.addIndex(line.getNumVertices() - 2);
          line.addIndex(line.getNumVertices() - 4);
        }
      }

      face.addIndex(face.getNumVertices() - 1);
      face.addIndex(0);
      face.addIndex(1);
      face.addIndex(face.getNumVertices() - 1);
      face.addIndex(face.getNumVertices() - 2);
      face.addIndex(2);

      line.addIndex(line.getNumVertices() - 1);
      line.addIndex(1);
      line.addIndex(line.getNumVertices() - 2);
      line.addIndex(0);

      push();
      colorMode(HSB, 255, 255, 255);
      color col = color(random(255), 130, 255);
      pop();
      face.draw(col);

      line.drawWireframe(color(255));
      popMatrix();
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
