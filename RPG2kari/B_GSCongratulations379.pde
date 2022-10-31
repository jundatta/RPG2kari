// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】中内　純(ハンドルネーム：JunKiyoshi)さん
// 【作品名】Rain on sphere. Draw by openFrameworks
// https://junkiyoshi.com/2021/11/09/
//

class GameSceneCongratulations379 extends GameSceneCongratulationsBase {
  @Override void setup() {
  }

  //--------------------------------------------------------------
  void update() {
    //  ofSeedRandom(39);
    // （なんとなくこっちの方がいい感じｗ）
    ofSeedRandom(5963);
  }

  //--------------------------------------------------------------
  @Override void draw() {
    push();
    update();
    translate(width/2, height/2);

    ofBackground(0);
    ofSetLineWidth(1.2);

    noFill();
    for (int k = 0; k < 150; k++) {
      pushMatrix();
      ofRotateZ(ofRandom(360));
      ofRotateY(ofRandom(360));
      ofRotateX(ofRandom(360));

      var location = new PVector(0, 0, 250);
      var radius = (int)(ofRandom(1000) + ofGetFrameNum() * 2) % 180 - 100;

      if (radius < 0) {
        var z = ofMap(radius, -100, 0, 1500, 0);
        stroke(255);
        //ofDrawLine(location + glm::vec3(0, 0, z), location + glm::vec3(0, 0, z + 40));
        PVector p1 = PVector.add(location, new PVector(0, 0, z));
        PVector p2 = PVector.add(location, new PVector(0, 0, z + 40));
        line(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z);
      } else {
        stroke(255, radius > 25 ? ofMap(radius, 25, 80, 255, 0) : 255);

        beginShape();
        for (int deg = 0; deg < 360; deg++) {
          //auto vertex = location + glm::vec2(radius * cos(deg * DEG_TO_RAD), radius * sin(deg * DEG_TO_RAD));
          PVector vertex = PVector.add(location, new PVector(radius * cos(deg * DEG_TO_RAD), radius * sin(deg * DEG_TO_RAD)));
          //vertex = glm::normalize(vertex) * 250;
          vertex = PVector.mult(vertex.normalize(), 250);
          vertex(vertex.x, vertex.y, vertex.z);
        }
        endShape(CLOSE);
      }
      popMatrix();
    }

    noStroke();
    fill(0);
    sphere(230);
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
