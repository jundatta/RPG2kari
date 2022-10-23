// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】中内　純(ハンドルネーム：JunKiyoshi)さん
// 【作品名】Cubic pyramid. Draw by openFrameworks
// https://junkiyoshi.com/2021/12/03/
//

class GameSceneCongratulations361 extends GameSceneCongratulationsBase {
  ofMesh face, frame;

  //--------------------------------------------------------------
  @Override void setup() {
    face = new ofMesh();
    frame = new ofMesh();
  }

  //--------------------------------------------------------------
  void update() {
    face.clear();
    frame.clear();

    int len = 600;
    int depth = len / 25;
    while (true) {
      var param_start = ofMap(openFrameworks.ofNoise(len * 0.002, ofGetFrameNum() * 0.0015), 0, 1, 0, 200);
      for (var param = param_start; param < param_start + 50; param += 2) {
        PVector v = make_point(len, param);
        setBoxToMesh(face, frame, new PVector(v.x, v.y, len / 2 + depth), len / 25);
      }
      len -= len / 10;
      if (len < 150) {
        break;
      }
    }
  }

  //--------------------------------------------------------------
  @Override void draw() {
    push();
    update();
    translate(width/2, height/2);
    background(255);
    strokeWeight(2);

    ofRotateY(ofGetFrameNum() * 0.666666666666);
    ofRotateZ(ofGetFrameNum() * 0.333333333333);

    for (int i = 0; i < 4; i++) {
      ofRotateY(90);
      face.draw(#ffffff);
      frame.drawWireframe(#000000);
    }
    pop();

    logoRightLower(#ff0000);
  }

  //--------------------------------------------------------------
  void setBoxToMesh(ofMesh face_target, ofMesh frame_target, PVector location, float size) {
    setBoxToMesh(face_target, frame_target, location, size, size, size);
  }

  //--------------------------------------------------------------
  void setBoxToMesh(ofMesh face_target, ofMesh frame_target, PVector location, float height, float width, float depth) {
    int face_index = face_target.getNumVertices();
    int frame_index = frame_target.getNumVertices();

    PVector v = new PVector(width * -0.5 * 0.99, height * 0.5 * 0.99, depth * -0.5 * 0.99);
    face_target.addVertex(PVector.add(location, v));
    v = new PVector(width * 0.5 * 0.99, height * 0.5 * 0.99, depth * -0.5 * 0.99);
    face_target.addVertex(PVector.add(location, v));
    v = new PVector(width * 0.5 * 0.99, height * 0.5 * 0.99, depth * 0.5 * 0.99);
    face_target.addVertex(PVector.add(location, v));
    v = new PVector(width * -0.5 * 0.99, height * 0.5 * 0.99, depth * 0.5 * 0.99);
    face_target.addVertex(PVector.add(location, v));

    v = new PVector(width * -0.5 * 0.99, height * -0.5 * 0.99, depth * -0.5 * 0.99);
    face_target.addVertex(PVector.add(location, v));
    v = new PVector(width * 0.5 * 0.99, height * -0.5 * 0.99, depth * -0.5 * 0.99);
    face_target.addVertex(PVector.add(location, v));
    v = new PVector(width * 0.5 * 0.99, height * -0.5 * 0.99, depth * 0.5 * 0.99);
    face_target.addVertex(PVector.add(location, v));
    v = new PVector(width * -0.5 * 0.99, height * -0.5 * 0.99, depth * 0.5 * 0.99);
    face_target.addVertex(PVector.add(location, v));

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
    face_target.addIndex(face_index + 1);
    face_target.addIndex(face_index + 4);
    face_target.addIndex(face_index + 5);
    face_target.addIndex(face_index + 1);

    face_target.addIndex(face_index + 1);
    face_target.addIndex(face_index + 5);
    face_target.addIndex(face_index + 6);
    face_target.addIndex(face_index + 6);
    face_target.addIndex(face_index + 2);
    face_target.addIndex(face_index + 1);

    face_target.addIndex(face_index + 2);
    face_target.addIndex(face_index + 6);
    face_target.addIndex(face_index + 7);
    face_target.addIndex(face_index + 7);
    face_target.addIndex(face_index + 3);
    face_target.addIndex(face_index + 2);

    face_target.addIndex(face_index + 3);
    face_target.addIndex(face_index + 7);
    face_target.addIndex(face_index + 4);
    face_target.addIndex(face_index + 4);
    face_target.addIndex(face_index + 0);
    face_target.addIndex(face_index + 3);

    v = new PVector(width * -0.5, height * 0.5, depth * -0.5);
    frame_target.addVertex(PVector.add(location, v));
    v = new PVector(width * 0.5, height * 0.5, depth * -0.5);
    frame_target.addVertex(PVector.add(location, v));
    v = new PVector(width * 0.5, height * 0.5, depth * 0.5);
    frame_target.addVertex(PVector.add(location, v));
    v = new PVector(width * -0.5, height * 0.5, depth * 0.5);
    frame_target.addVertex(PVector.add(location, v));

    v = new PVector(width * -0.5, height * -0.5, depth * -0.5);
    frame_target.addVertex(PVector.add(location, v));
    v = new PVector(width * 0.5, height * -0.5, depth * -0.5);
    frame_target.addVertex(PVector.add(location, v));
    v = new PVector(width * 0.5, height * -0.5, depth * 0.5);
    frame_target.addVertex(PVector.add(location, v));
    v = new PVector(width * -0.5, height * -0.5, depth * 0.5);
    frame_target.addVertex(PVector.add(location, v));

    frame_target.addIndex(frame_index + 0);
    frame_target.addIndex(frame_index + 1);
    frame_target.addIndex(frame_index + 1);
    frame_target.addIndex(frame_index + 2);
    frame_target.addIndex(frame_index + 2);
    frame_target.addIndex(frame_index + 3);
    frame_target.addIndex(frame_index + 3);
    frame_target.addIndex(frame_index + 0);

    frame_target.addIndex(frame_index + 4);
    frame_target.addIndex(frame_index + 5);
    frame_target.addIndex(frame_index + 5);
    frame_target.addIndex(frame_index + 6);
    frame_target.addIndex(frame_index + 6);
    frame_target.addIndex(frame_index + 7);
    frame_target.addIndex(frame_index + 7);
    frame_target.addIndex(frame_index + 4);

    frame_target.addIndex(frame_index + 0);
    frame_target.addIndex(frame_index + 4);
    frame_target.addIndex(frame_index + 1);
    frame_target.addIndex(frame_index + 5);
    frame_target.addIndex(frame_index + 2);
    frame_target.addIndex(frame_index + 6);
    frame_target.addIndex(frame_index + 3);
    frame_target.addIndex(frame_index + 7);
  }

  //--------------------------------------------------------------
  PVector make_point(int len, float param) {
    PVector base, next;

    var param_i =  (int)param % 100;
    var param_p = param - (int)param;

    if (param_i < 25) {
      base = new PVector(ofMap(param_i, 0, 25, -len * 0.5, len * 0.5), -len * 0.5);
    } else if (param_i < 50) {
      base = new PVector(len * 0.5, ofMap(param_i, 25, 50, -len * 0.5, len * 0.5));
    } else if (param_i < 75) {
      base = new PVector(ofMap(param_i, 50, 75, len * 0.5, -len * 0.5), len * 0.5);
    } else {
      base = new PVector(-len * 0.5, ofMap(param_i, 75, 100, len * 0.5, -len * 0.5));
    }

    param_i = (param_i + 1) % 100;
    if (param_i < 25) {
      next = new PVector(ofMap(param_i, 0, 25, -len * 0.5, len * 0.5), -len * 0.5);
    } else if (param_i < 50) {
      next = new PVector(len * 0.5, ofMap(param_i, 25, 50, -len * 0.5, len * 0.5));
    } else if (param_i < 75) {
      next = new PVector(ofMap(param_i, 50, 75, len * 0.5, -len * 0.5), len * 0.5);
    } else {
      next = new PVector(-len * 0.5, ofMap(param_i, 75, 100, len * 0.5, -len * 0.5));
    }

    //  return base + (next - base) * param_p;
    PVector v = PVector.sub(next, base);
    v.mult(param_p);
    v = PVector.add(base, v);
    return v;
  }
  @Override void mousePressed() {
    gGameStack.change(new GameSceneTitle());
  }
  @Override void keyPressed() {
    super.keyPressed();

    gGameStack.change(new GameSceneTitle());
  }
}
