// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】中内　純(ハンドルネーム：JunKiyoshi)さん
// 【作品名】Mountains of Noise. Draw by openFrameworks
// https://junkiyoshi.com/2021/11/25/
//

class GameSceneCongratulations370 extends GameSceneCongratulationsBase {
  ofMesh face, line;

  //--------------------------------------------------------------
  @Override void setup() {
    face = new ofMesh();
    line = new ofMesh();
  }

  //--------------------------------------------------------------
  void update() {
    ofSeedRandom(39);

    face.clear();
    line.clear();

    var x_span = 1;
    var z_span = 20;
    for (var z = -100; z <= 100; z += z_span) {
      var start_index = face.getNumVertices();

      var param_noise_value = openFrameworks.ofNoise(z * 0.035, ofGetFrameNum() * 0.0001);

      for (var x = -500; x <= 500; x += x_span) {
        ArrayList<PVector> vertices = new ArrayList();

        var noise_value = openFrameworks.ofNoise(z * 0.05, x * 0.035, ofGetFrameNum() * 0.005);
        var next_noise_value = openFrameworks.ofNoise(z * 0.05, (x + x_span) * 0.035, ofGetFrameNum() * 0.005);

        if (abs(x) <= 150) {
          var param = ofMap(param_noise_value, 0, 1, -150, 150);
          var distance = abs(x - param);
          noise_value = noise_value * (distance > 30 ? 0.1 : ofMap(distance, 0, 30, 0.5, 0.1)) * (abs(x) < 100 ? 1 : ofMap(abs(x), 100, 150, 1, 0));
        } else {
          noise_value = 0;
        }

        if (abs(x + x_span) <= 150) {
          var param = ofMap(param_noise_value, 0, 1, -150, 150);
          var distance = abs((x + x_span) - param);
          next_noise_value = next_noise_value * (distance > 30 ? 0.1 : ofMap(distance, 0, 30, 0.5, 0.1)) * (abs(x + x_span) < 100 ? 1 : ofMap(abs(x + x_span), 100, 150, 1, 0));
        } else {
          next_noise_value = 0;
        }

        var height = ofMap(noise_value, 0, 1, -150, 350);
        var next_height = ofMap(next_noise_value, 0, 1, -150, 350);

        vertices.add(new PVector(x, -150, z - 4.5));
        vertices.add(new PVector(x + x_span, -150, z - 4.5));
        vertices.add(new PVector(x + x_span, next_height, z - 4.5));
        vertices.add(new PVector(x, height, z - 4.5));

        vertices.add(new PVector(x, -150, z + 4.5));
        vertices.add(new PVector(x + x_span, -150, z + 4.5));
        vertices.add(new PVector(x + x_span, next_height, z + 4.5));
        vertices.add(new PVector(x, height, z + 4.5));

        var index = face.getNumVertices();
        face.addVertices(vertices);

        face.addIndex(index + 0);
        face.addIndex(index + 1);
        face.addIndex(index + 2);
        face.addIndex(index + 0);
        face.addIndex(index + 2);
        face.addIndex(index + 3);

        face.addIndex(index + 4);
        face.addIndex(index + 5);
        face.addIndex(index + 6);
        face.addIndex(index + 4);
        face.addIndex(index + 6);
        face.addIndex(index + 7);

        face.addIndex(index + 0);
        face.addIndex(index + 4);
        face.addIndex(index + 5);
        face.addIndex(index + 0);
        face.addIndex(index + 5);
        face.addIndex(index + 1);

        face.addIndex(index + 2);
        face.addIndex(index + 6);
        face.addIndex(index + 7);
        face.addIndex(index + 2);
        face.addIndex(index + 7);
        face.addIndex(index + 3);

        line.addVertices(vertices);

        line.addIndex(index + 0);
        line.addIndex(index + 1);
        line.addIndex(index + 2);
        line.addIndex(index + 3);
        line.addIndex(index + 4);
        line.addIndex(index + 5);
        line.addIndex(index + 6);
        line.addIndex(index + 7);

        for (int i = index; i < index + 8; i++) {
          face.addColor(color(0));
          line.addColor(color(255));
        }
      }

      face.addIndex(start_index + 0);
      face.addIndex(start_index + 4);
      face.addIndex(start_index + 7);
      face.addIndex(start_index + 0);
      face.addIndex(start_index + 7);
      face.addIndex(start_index + 3);

      line.addIndex(start_index + 0);
      line.addIndex(start_index + 3);
      line.addIndex(start_index + 0);
      line.addIndex(start_index + 4);
      line.addIndex(start_index + 7);
      line.addIndex(start_index + 3);
      line.addIndex(start_index + 7);
      line.addIndex(start_index + 4);

      var index = face.getNumVertices() - 8;

      face.addIndex(index + 1);
      face.addIndex(index + 2);
      face.addIndex(index + 6);
      face.addIndex(index + 1);
      face.addIndex(index + 6);
      face.addIndex(index + 5);

      line.addIndex(index + 1);
      line.addIndex(index + 2);
      line.addIndex(index + 1);
      line.addIndex(index + 5);
      line.addIndex(index + 6);
      line.addIndex(index + 2);
      line.addIndex(index + 6);
      line.addIndex(index + 5);
    }
  }

  //--------------------------------------------------------------
  @Override void draw() {
    push();
    update();
    translate(width/2, height/2);
    scale(1, -1, 1);
    // 好みで見栄え調整させて頂きました＼(^_^)／
    translate(0, 75, 250);
    ofBackground(0);
    ofSetLineWidth(2);

    ofRotateY(180 + ofGetFrameNum() * 0.75);

    face.draw();
    line.drawWireframe();
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
