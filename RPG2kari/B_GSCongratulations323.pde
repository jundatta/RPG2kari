// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】中内　純(ハンドルネーム：JunKiyoshi)さん
// 【作品名】Rotating rectangles. Draw by openFrameworks
// https://junkiyoshi.com/2022/01/04/
//

class GameSceneCongratulations323 extends GameSceneCongratulationsBase {
  ofMesh face, frame;

  @Override void setup() {
    face = new ofMesh();
    frame = new ofMesh();
  }

  //--------------------------------------------------------------
  void update() {
    randomSeed(39);

    face.clear();
    frame.clear();

    int y = 200;
    for (int x = -300 * 3; x <= 300 * 3; x += 300) {
      var noise_seed = random(1000);
      for (int i = 1; i >= -1; i -= 2) {
        for (var radius = 50; radius <= 150; radius += 5) {
          var noise_value = openFrameworks.ofNoise(noise_seed, radius * 0.00085 + frameCount * 0.0015);
          //auto rotation = glm::rotate(glm::mat4(), ofMap(noise_value, 0, 1, -720, 720) * (float)DEG_TO_RAD, glm::vec3(1, 0, 0));
          PMatrix3D rotation = new PMatrix3D();
          rotation.rotateX(map(noise_value, 0, 1, -720, 720) * DEG_TO_RAD);

          if (i == 1) {
            setRingToMesh(face, frame, new PVector(x, y * i, 0), radius, 2, 30, rotation, color(0), color(255));
          } else {
            setRingToMesh(face, frame, new PVector(x, y * i, 0), radius, 2, 30, rotation, color(255), color(0));
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

    rotateX(radians(90));

    face.draw();

    stroke(255);
    frame.drawWireframe();
    pop();

    logoRightLower(#ff0000);
  }

  //--------------------------------------------------------------
  void setRingToMesh(ofMesh face_target, ofMesh frame_target, PVector location, float radius, float width, float height, PMatrix3D rotation, color face_color, color line_color) {
    int deg_span = 90;
    for (int deg = 45; deg < 400; deg += deg_span) {
      var face_index = face_target.getNumVertices();

      ArrayList<PVector> vertices = new ArrayList();
      vertices.add(new PVector((radius + width * 0.5) * cos(deg * DEG_TO_RAD), (radius + width * 0.5) * sin(deg * DEG_TO_RAD), height * -0.5));
      vertices.add(new PVector((radius + width * 0.5) * cos((deg + deg_span) * DEG_TO_RAD), (radius + width * 0.5) * sin((deg + deg_span) * DEG_TO_RAD), height * -0.5));
      vertices.add(new PVector((radius + width * 0.5) * cos((deg + deg_span) * DEG_TO_RAD), (radius + width * 0.5) * sin((deg + deg_span) * DEG_TO_RAD), height * 0.5));
      vertices.add(new PVector((radius + width * 0.5) * cos(deg * DEG_TO_RAD), (radius + width * 0.5) * sin(deg * DEG_TO_RAD), height * 0.5));

      vertices.add(new PVector((radius - width * 0.5) * cos(deg * DEG_TO_RAD), (radius - width * 0.5) * sin(deg * DEG_TO_RAD), height * -0.5));
      vertices.add(new PVector((radius - width * 0.5) * cos((deg + deg_span) * DEG_TO_RAD), (radius - width * 0.5) * sin((deg + deg_span) * DEG_TO_RAD), height * -0.5));
      vertices.add(new PVector((radius - width * 0.5) * cos((deg + deg_span) * DEG_TO_RAD), (radius - width * 0.5) * sin((deg + deg_span) * DEG_TO_RAD), height * 0.5));
      vertices.add(new PVector((radius - width * 0.5) * cos(deg * DEG_TO_RAD), (radius - width * 0.5) * sin(deg * DEG_TO_RAD), height * 0.5));

      ArrayList<PVector> newVertices = new ArrayList();
      for (PVector vertex : vertices) {
        //vertex = glm::vec4(vertex + location, 0) * rotation;
        vertex = vertex.add(location);
        vertex = rotation.mult(vertex, null);
        newVertices.add(vertex);
      }
      vertices = newVertices;

      face_target.addVertices(vertices);

      face_target.addIndex(face_index + 0);
      face_target.addIndex(face_index + 1);
      face_target.addIndex(face_index + 2);
      face_target.addIndex(face_index + 0);
      face_target.addIndex(face_index + 2);
      face_target.addIndex(face_index + 3);

      face_target.addIndex(face_index + 4);
      face_target.addIndex(face_index + 5);
      face_target.addIndex(face_index + 6);
      face_target.addIndex(face_index + 4);
      face_target.addIndex(face_index + 6);
      face_target.addIndex(face_index + 7);

      face_target.addIndex(face_index + 0);
      face_target.addIndex(face_index + 4);
      face_target.addIndex(face_index + 5);
      face_target.addIndex(face_index + 0);
      face_target.addIndex(face_index + 5);
      face_target.addIndex(face_index + 1);

      face_target.addIndex(face_index + 3);
      face_target.addIndex(face_index + 7);
      face_target.addIndex(face_index + 6);
      face_target.addIndex(face_index + 3);
      face_target.addIndex(face_index + 6);
      face_target.addIndex(face_index + 2);

      var frame_index = frame_target.getNumVertices();

      frame_target.addVertices(vertices);

      frame_target.addIndex(frame_index + 0);
      frame_target.addIndex(frame_index + 1);
      frame_target.addIndex(frame_index + 2);
      frame_target.addIndex(frame_index + 3);
      frame_target.addIndex(frame_index + 4);
      frame_target.addIndex(frame_index + 5);
      frame_target.addIndex(frame_index + 6);
      frame_target.addIndex(frame_index + 7);

      frame_target.addIndex(frame_index + 0);
      frame_target.addIndex(frame_index + 3);

      for (int i = 0; i < vertices.size(); i++) {
        face_target.addColor(face_color);
        frame_target.addColor(line_color);
      }
    }
  }
  
  @Override void mousePressed() {
    gGameStack.change(new GameSceneTitle());
  }
  @Override void keyPressed() {
    super.keyPressed();

    gGameStack.change(new GameSceneTitle());
  }
}
