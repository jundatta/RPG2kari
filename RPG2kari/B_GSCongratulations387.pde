// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】中内　純(ハンドルネーム：JunKiyoshi)さん
// 【作品名】Walker from circle to square. Draw by openFrameworks
// https://junkiyoshi.com/2021/10/12/
//

class GameSceneCongratulations387 extends GameSceneCongratulationsBase {
  ArrayList<PVector> base_location_list = new ArrayList();
  ArrayList<ArrayList<PVector>> log_list = new ArrayList();

  PGraphics pg;
  int OrgW = 720;
  int OrgH = 720;
  //--------------------------------------------------------------
  @Override void setup() {
    int radius = 100;
    for (float deg = 0; deg < 360; deg += 10) {
      var location = new PVector(radius * cos(deg * DEG_TO_RAD), radius * sin(deg * DEG_TO_RAD));
      base_location_list.add(location);
    }

    pg = createGraphics(OrgW, OrgH);
  }

  //--------------------------------------------------------------
  void update() {
    log_list.clear();

    int limit = 300;
    for (int i = 0; i < base_location_list.size(); i++) {
      ArrayList<PVector> log = new ArrayList();
      //PVector base = base_location_list.get(i);
      log.add(base_location_list.get(i));
      log_list.add(log);
    }

    int step = 1;
    for (int i = 0; i < log_list.size(); i++) {
      int k = 0;
      while (true) {
        ArrayList<PVector> logArray = log_list.get(i);
        int last = logArray.size() - 1;
        PVector lastP = logArray.get(last);
        PVector log = PVector.mult(lastP, 0.0035);
        PVector p = new PVector(log.x, log.y, ofGetFrameNum() * 0.003 + k * 0.0005);
        var deg = ofMap(openFrameworks.ofNoise(p.x, p.y, p.z), 0, 1, -360, 360);
        var next = new PVector(step * cos(deg * DEG_TO_RAD), step * sin(deg * DEG_TO_RAD));
        next.add(lastP);
        if (next.x < -limit || next.x > limit || next.y < -limit || next.y > limit) {
          break;
        }
        logArray.add(next);
        k++;
      }
    }
  }

  //--------------------------------------------------------------
  @Override void draw() {
    push();
    update();
    //translate(width/2, height/2);

    pg.beginDraw();
    pg.background(0);
    //ofEnableBlendMode(ofBlendMode::OF_BLENDMODE_ADD);
    pg.blendMode(ADD);

    pg.translate(pg.width * 0.5, pg.height * 0.5);

    pg.strokeWeight(1.2);
    for (int i = 0; i < log_list.size(); i++) {
      ArrayList<PVector> logArray = log_list.get(i);
      if (logArray.size() > 1) {
        pg.noFill();
        pg.stroke(39, 39, 239);
        pg.beginShape();
        //ofVertices(logArray);
        for (var log : logArray) {
          pg.vertex(log.x, log.y);
        }
        pg.endShape();

        pg.noStroke();
        pg.fill(255);
        int last = logArray.size() - 1;
        PVector lastP = logArray.get(last);
        pg.circle(lastP.x, lastP.y, 3 * 2);
        pg.fill(39, 39, 239);
        PVector frontP = logArray.get(0);
        pg.circle(frontP.x, frontP.y, 3 * 2);
      }
    }

    pg.noFill();
    pg.strokeWeight(0.2 * 4);
    pg.stroke(255);
    pg.rect(-300, -300, 600, 600);
    pg.endDraw();
    image(pg, 0, 0, width, height);
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
