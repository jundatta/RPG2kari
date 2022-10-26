// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】中内　純(ハンドルネーム：JunKiyoshi)さん
// 【作品名】Rotate rectangles. Draw by openFrameworks
// https://junkiyoshi.com/2021/11/29/
//

class GameSceneCongratulations365 extends GameSceneCongratulationsBase {
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

    for (int x = -300; x <= 300; x += 300) {
      for (int y = -300; y <= 300; y += 300) {
        //glm::highp_mat4 rotation;
        //auto noise_value = ofNoise(abs(x), y, ofGetFrameNum() * 0.003);
        //rotation = glm::rotate(glm::mat4(), ofMap(noise_value, 0, 1, -360, 360) * (float)DEG_TO_RAD, glm::vec3(0, 1, 0));
        PMatrix3D rotation = new PMatrix3D();
        var noise_value = openFrameworks.ofNoise(abs(x), y, ofGetFrameNum() * 0.003);
        rotation.rotateY(ofMap(noise_value, 0, 1, -360, 360) * (float)DEG_TO_RAD);
        setRingToMesh(face, frame, new PVector(x, y, 0), 0, 50, 10, rotation);

        for (var radius = 60; radius <= 190; radius += 30) {
          //glm::highp_mat4 rotation;
          //auto noise_value = ofNoise(abs(x), y, (ofGetFrameNum() + radius) * 0.003);
          PMatrix3D rotationIn = new PMatrix3D();
          var noise_valueIn = openFrameworks.ofNoise(abs(x), y, (ofGetFrameNum() + radius) * 0.003);

          if (noise_value < 0.2) {
            noise_value = 0;
          } else if (noise_value < 0.4) {
            noise_value = ofMap(noise_value, 0.2, 0.4, 0, 0.5);
          } else if (noise_value < 0.6) {
            noise_value = 0.5;
          } else if (noise_value < 0.8) {
            noise_value = ofMap(noise_value, 0.6, 0.8, 0.5, 1.0);
          } else {
            noise_value = 1;
          }

          //rotation = glm::rotate(glm::mat4(), ofMap(noise_value, 0, 1, -180, 180) * (float)DEG_TO_RAD, glm::vec3(0, 1, 0));
          rotationIn.rotateY(ofMap(noise_valueIn, 0, 1, -180, 180) * (float)DEG_TO_RAD);
          setRingToMesh(face, frame, new PVector(x, y, 0), radius, 28, 10, rotationIn);
        }
      }
    }
  }

  //--------------------------------------------------------------
  @Override void draw() {
    push();
    update();
    translate(width/2, height/2);
    translate(0, -100, -300);
    ofRotateX(45);
    ofRotateZ(45);
    background(0);

    face.draw(#000000);

    frame.drawWireframe(#ffffff);
    pop();

    logoRightLower(#ff0000);
  }

  //--------------------------------------------------------------
  void setRingToMesh(ofMesh face_target, ofMesh frame_target, PVector location, float radius, float width, float height, PMatrix3D rotation) {
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
