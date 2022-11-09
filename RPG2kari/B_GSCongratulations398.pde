// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】中内　純(ハンドルネーム：JunKiyoshi)さん
// 【作品名】Rising intersection. Draw by openFrameworks
// https://junkiyoshi.com/2021/08/31/
//

class GameSceneCongratulations398 extends GameSceneCongratulationsBase {
  class pair {
    PVector first;
    float second;

    pair(PVector f, float s) {
      first = f;
      second = s;
    }
  }
  ArrayList<pair> box_info_list = new ArrayList();
  IntList box_color_list = new IntList();
  ArrayList<pair> wave_list = new ArrayList();
  float size;

  ofMesh face = new ofMesh();
  ofMesh frame = new ofMesh();

  @Override void setup() {
    push();
    colorMode(HSB, 256, 256, 256);
    size = 5;
    color col;
    for (var x = -450; x <= 450; x += size) {
      for (var y = -450; y <= 450; y += size) {
        box_info_list.add(new pair(new PVector(x, y), 0.f));
        //color.setHsb(ofRandom(255), 130, 255);
        col = color(ofRandom(255), 130, 255);
        box_color_list.append(col);
      }
    }
    pop();
  }

  //--------------------------------------------------------------
  void update() {
    face.clear();
    frame.clear();

    if (ofGetFrameNum() % 20 == 0) {
      var l = new PVector(ofRandom(-250, 250), ofRandom(-250, 250));
      var f = 5.0f;
      wave_list.add(new pair(l, f));
    }

    var max_height = 150;
    for (var wave : wave_list) {
      for (var box_info : box_info_list) {
        var distance = PVector.dist(wave.first, new PVector(box_info.first.x, box_info.first.y));
        if (distance > wave.second - 10 && distance < wave.second + 10) {
          box_info.second = (box_info.second >= 1) ? 1 : box_info.second + ofMap(abs(distance - wave.second), 0, 20, 0.125, 0);
        } else {
          box_info.second = (box_info.second <= 0) ? 0 : box_info.second - 0.018;
        }
      }
      wave.second += 3;
    }

    push();
    colorMode(HSB, 256, 256, 256);
    for (int i = 0; i < box_info_list.size(); i++) {
      var box_info = box_info_list.get(i);
      if (box_info.second > 0) {
        var len = ofMap(openFrameworks.ofNoise(box_info.first.x * 0.02, box_info.first.y * 0.02, ofGetFrameNum() * 0.01), 0, 1, 0, max_height * box_info.second);
        setBoxToMesh(face, frame, new PVector(box_info.first.x, box_info.first.y, len * 0.5), size, size, len, box_color_list.get(i));
      } else {
        //color.setHsb(ofRandom(255), 130, 255);
        box_color_list.set(i, color(ofRandom(255), 130, 255));
      }
    }
    pop();

    for (int i = wave_list.size() - 1; i >= 0; i--) {
      if (wave_list.get(i).second > 450) {
        //wave_list.erase(wave_list.begin() + i);
        wave_list.remove(i);
      }
    }
  }

  //--------------------------------------------------------------
  @Override void draw() {
    push();
    update();
    translate(width/2, height/2);
    scale(1, -1, 1);

    ofBackground(239);
    ofSetLineWidth(0.5 * 2);

    ofRotateX(295);

    face.drawFaces();

    frame.drawWireframe(color(39));
    pop();

    logoRightLower(#ff0000);
  }

  //--------------------------------------------------------------
  void setBoxToMesh(ofMesh face_target, ofMesh frame_target, PVector location, float size, color col) {
    setBoxToMesh(face_target, frame_target, location, size, size, size, col);
  }

  //--------------------------------------------------------------
  void setBoxToMesh(ofMesh face_target, ofMesh frame_target, PVector location, float height, float width, float depth, color col) {
    int index = face_target.getVertices().size();

    face_target.addVertex(PVector.add(location, new PVector(width * -0.5 * 0.999, height * 0.5 * 0.999, depth * -0.5 * 0.999)));
    face_target.addVertex(PVector.add(location, new PVector(width * 0.5 * 0.999, height * 0.5 * 0.999, depth * -0.5 * 0.999)));
    face_target.addVertex(PVector.add(location, new PVector(width * 0.5 * 0.999, height * 0.5 * 0.999, depth * 0.5 * 0.999)));
    face_target.addVertex(PVector.add(location, new PVector(width * -0.5 * 0.999, height * 0.5 * 0.999, depth * 0.5 * 0.999)));

    face_target.addVertex(PVector.add(location, new PVector(width * -0.5 * 0.999, height * -0.5 * 0.999, depth * -0.5 * 0.999)));
    face_target.addVertex(PVector.add(location, new PVector(width * 0.5 * 0.999, height * -0.5 * 0.999, depth * -0.5 * 0.999)));
    face_target.addVertex(PVector.add(location, new PVector(width * 0.5 * 0.999, height * -0.5 * 0.999, depth * 0.5 * 0.999)));
    face_target.addVertex(PVector.add(location, new PVector(width * -0.5 * 0.999, height * -0.5 * 0.999, depth * 0.5 * 0.999)));

    face_target.addIndex(index + 0);
    face_target.addIndex(index + 1);
    face_target.addIndex(index + 2);
    face_target.addIndex(index + 0);
    face_target.addIndex(index + 2);
    face_target.addIndex(index + 3);

    face_target.addIndex(index + 4);
    face_target.addIndex(index + 5);
    face_target.addIndex(index + 6);
    face_target.addIndex(index + 4);
    face_target.addIndex(index + 6);
    face_target.addIndex(index + 7);

    face_target.addIndex(index + 0);
    face_target.addIndex(index + 4);
    face_target.addIndex(index + 1);
    face_target.addIndex(index + 4);
    face_target.addIndex(index + 5);
    face_target.addIndex(index + 1);

    face_target.addIndex(index + 1);
    face_target.addIndex(index + 5);
    face_target.addIndex(index + 6);
    face_target.addIndex(index + 6);
    face_target.addIndex(index + 2);
    face_target.addIndex(index + 1);

    face_target.addIndex(index + 2);
    face_target.addIndex(index + 6);
    face_target.addIndex(index + 7);
    face_target.addIndex(index + 7);
    face_target.addIndex(index + 3);
    face_target.addIndex(index + 2);

    face_target.addIndex(index + 3);
    face_target.addIndex(index + 7);
    face_target.addIndex(index + 4);
    face_target.addIndex(index + 4);
    face_target.addIndex(index + 0);
    face_target.addIndex(index + 3);

    frame_target.addVertex(PVector.add(location, new PVector(width * -0.5, height * 0.5, depth * -0.5)));
    frame_target.addVertex(PVector.add(location, new PVector(width * 0.5, height * 0.5, depth * -0.5)));
    frame_target.addVertex(PVector.add(location, new PVector(width * 0.5, height * 0.5, depth * 0.5)));
    frame_target.addVertex(PVector.add(location, new PVector(width * -0.5, height * 0.5, depth * 0.5)));

    frame_target.addVertex(PVector.add(location, new PVector(width * -0.5, height * -0.5, depth * -0.5)));
    frame_target.addVertex(PVector.add(location, new PVector(width * 0.5, height * -0.5, depth * -0.5)));
    frame_target.addVertex(PVector.add(location, new PVector(width * 0.5, height * -0.5, depth * 0.5)));
    frame_target.addVertex(PVector.add(location, new PVector(width * -0.5, height * -0.5, depth * 0.5)));

    frame_target.addIndex(index + 0);
    frame_target.addIndex(index + 1);
    frame_target.addIndex(index + 1);
    frame_target.addIndex(index + 2);
    frame_target.addIndex(index + 2);
    frame_target.addIndex(index + 3);
    frame_target.addIndex(index + 3);
    frame_target.addIndex(index + 0);

    frame_target.addIndex(index + 4);
    frame_target.addIndex(index + 5);
    frame_target.addIndex(index + 5);
    frame_target.addIndex(index + 6);
    frame_target.addIndex(index + 6);
    frame_target.addIndex(index + 7);
    frame_target.addIndex(index + 7);
    frame_target.addIndex(index + 4);

    frame_target.addIndex(index + 0);
    frame_target.addIndex(index + 4);
    frame_target.addIndex(index + 1);
    frame_target.addIndex(index + 5);
    frame_target.addIndex(index + 2);
    frame_target.addIndex(index + 6);
    frame_target.addIndex(index + 3);
    frame_target.addIndex(index + 7);

    for (int i = 0; i < 8; i++) {
      face_target.addColor(color(col));
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
