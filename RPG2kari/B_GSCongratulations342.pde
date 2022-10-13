// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】中内　純(ハンドルネーム：JunKiyoshi)さん
// 【作品名】Connection bubble. Draw by openFrameworks
// https://junkiyoshi.com/2021/12/20/
//

class GameSceneCongratulations342 extends GameSceneCongratulationsBase {
  ofMesh mesh;
  ArrayList<PVector> circle_list;

  PGraphics pg;

  //--------------------------------------------------------------
  @Override void setup() {
    pg = createGraphics(width, height);

    mesh = new ofMesh();
    circle_list = new ArrayList();
  }

  //--------------------------------------------------------------
  void update() {
    randomSeed(39);

    mesh.clear();
    circle_list.clear();

    ArrayList<PVector> location_list = new ArrayList();
    for (int i = 0; i < 120; i++) {
      var location = new PVector(map(openFrameworks.ofNoise(random(1000), frameCount * 0.0035), 0, 1, -300, 300),
        map(openFrameworks.ofNoise(random(1000), frameCount * 0.0035), 0, 1, -300, 300));
      location_list.add(location);
    }

    for (int i = 0; i < location_list.size(); i++) {
      int near_count = 0;
      for (int k = 0; k < location_list.size(); k++) {
        if (i == k) {
          continue;
        }

        float distance = PVector.dist(location_list.get(i), location_list.get(k));
        if (distance < 50) {
          mesh.addVertex(location_list.get(i));
          mesh.addVertex(location_list.get(k));

          mesh.addIndex(mesh.getNumVertices() - 1);
          mesh.addIndex(mesh.getNumVertices() - 2);

          near_count++;
        }
      }
      PVector loc = location_list.get(i);
      PVector cir = new PVector(loc.x, loc.y, pow(1.5, near_count));
      circle_list.add(cir);
    }
  }

  //--------------------------------------------------------------
  @Override void draw() {
    push();
    update();
    //translate(width/2, height/2);
    pg.beginDraw();
    pg.background(0);

    pg.translate(width * 0.5, height * 0.5);

    pg.strokeWeight(0.5);
    mesh.drawWireframe(pg, color(255));

    pg.strokeWeight(1.5);
    for (PVector circle : circle_list) {
      pg.noStroke();
      pg.fill(0);
      pg.circle(circle.x, circle.y, circle.z);

      pg.stroke(255);
      pg.noFill();
      pg.circle(circle.x, circle.y, circle.z);
    }
    pg.endDraw();
    image(pg, 0, 0);
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
